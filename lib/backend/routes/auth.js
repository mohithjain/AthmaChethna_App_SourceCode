const express = require("express");
const dotenv = require("dotenv");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const User = require("../models/User");
const { sendOTP, verifyOTP } = require("../utils/sendOtp"); // Signup OTP functions
const { sendForgotPasswordOTP } = require("../utils/forgotPasswordOtp"); // Forgot Password OTP functions
const { verifyForgotPasswordOTP } = require("../utils/forgotPasswordOtp");
dotenv.config();
const router = express.Router();

/* =========================== SIGNUP & LOGIN =========================== */

// ✅ SIGNUP ROUTE (Generates OTP & Stores User)
router.post("/signup", async (req, res) => {
  const { name, username, password, email, semester, department, phone } = req.body;

  try {
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "Email is already registered" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const newUser = new User({ name, username, password: hashedPassword, email, semester, department, phone });
    await newUser.save();

    const otpSent = await sendOTP(email);
    if (!otpSent) {
      return res.status(500).json({ message: "Failed to send OTP. Please try again." });
    }

    res.status(201).json({ message: "Signup successful. OTP sent to email." });

  } catch (error) {
    console.error("❌ Signup Error:", error);
    res.status(500).json({ message: "Signup failed", error: error.message });
  }
});

// ✅ OTP VERIFICATION ROUTE
router.post("/verify-otp", async (req, res) => {
  const { email, otp } = req.body;

  try {
    const verificationResult = await verifyOTP(email, otp);

    if (!verificationResult.success) {
      return res.status(400).json({ message: verificationResult.message });
    }

    res.status(200).json({ message: "OTP verified successfully. You can now log in." });

  } catch (error) {
    console.error("❌ OTP Verification Error:", error);
    res.status(500).json({ message: "OTP verification failed", error: error.message });
  }
});

// ✅ LOGIN ROUTE (Modified to Include userId in Response)
router.post("/login", async (req, res) => {
  const { username, email, password } = req.body;

  try {
    const user = await User.findOne({
      $or: [{ email }, { username }]
    });

    if (!user) {
      return res.status(400).json({ message: "User not found" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: "Invalid credentials" });
    }

    const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, { expiresIn: "7d" });

    // ✅ Added userId to response
    res.status(200).json({ 
      message: "Login successful",
      user: {
        _id: user._id,
        username: user.username,
        email: user.email,
      },
      token 
    });

  } catch (error) {
    console.error("❌ Login Error:", error);
    res.status(500).json({ message: "Login failed", error: error.message });
  }
});

/* =========================== FORGOT PASSWORD =========================== */

// ✅ FORGOT PASSWORD - SEND OTP
router.post("/forgotpassword", async (req, res) => {
  const { email } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const otpSent = await sendForgotPasswordOTP(email);
    if (!otpSent) {
      return res.status(500).json({ message: "Failed to send OTP. Please try again." });
    }

    res.status(200).json({ message: "OTP sent to email for password reset." });

  } catch (error) {
    console.error("❌ Forgot Password Error:", error);
    res.status(500).json({ message: "Failed to send OTP", error: error.message });
  }
});

// ✅ VERIFY FORGOT PASSWORD OTP
router.post("/verify-forgot-password-otp", async (req, res) => {
  const { email, otp } = req.body;

  try {
    const verificationResult = await verifyForgotPasswordOTP(email, otp);

    if (!verificationResult.success) {
      return res.status(400).json({ message: verificationResult.message });
    }

    res.status(200).json({ message: "OTP verified. You can reset your password now." });

  } catch (error) {
    console.error("❌ OTP Verification Error:", error);
    res.status(500).json({ message: "OTP verification failed", error: error.message });
  }
});

// ✅ RESET PASSWORD ROUTE
router.post("/reset-password", async (req, res) => {
  const { email, newPassword } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(newPassword, salt);
    user.password = hashedPassword;
    await user.save();

    res.status(200).json({ message: "Password reset successful. You can now log in." });

  } catch (error) {
    console.error("❌ Password Reset Error:", error);
    res.status(500).json({ message: "Password reset failed", error: error.message });
  }
});

// ✅ Fetch User Details by userId (Protected Route)
router.get("/user/:userId", async (req, res) => {
  const { userId } = req.params;

  try {
      const user = await User.findById(userId).select("name semester department");
      if (!user) {
          return res.status(404).json({ message: "User not found" });
      }
      console.log("User fetched:", user); // ✅ DEBUG LOG

      res.status(200).json({
          message: "User details fetched successfully",
          user: {
              name: user.name,
              semester: user.semester,
              department: user.department,
          },
     });
 } catch (error) {
      console.error("❌ Error fetching user details:", error);
      res.status(500).json({ message: "Error fetching user details" });
  }
});


module.exports = router;
