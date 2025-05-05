const nodemailer = require("nodemailer");
const User = require("../models/User"); // Import User model

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.SMTP_EMAIL,
    pass: process.env.SMTP_PASSWORD,
  },
});

// ✅ Function to Generate & Store OTP
const generateAndStoreOTP = async (email) => {
  const otp = Math.floor(1000 + Math.random() * 9000); // Generate 4-digit OTP
  const otpExpiresAt = new Date(Date.now() + 5 * 60 * 1000); // Expires in 5 minutes

  // Find user and update OTP & expiry
  const user = await User.findOneAndUpdate(
    { email },
    { otp, otpExpiresAt },
    { new: true }
  );

  if (!user) {
    console.log("❌ User not found for OTP");
    return false;
  }

  return otp; // Return the new OTP for sending via email
};

// ✅ Function to Send OTP
const sendOTP = async (email) => {
  const otp = await generateAndStoreOTP(email);
  if (!otp) return false; // If user is not found, return false

  const mailOptions = {
    from: process.env.SMTP_EMAIL,
    to: email,
    subject: "Your OTP for Signup Verification",
    text: `Your OTP code is: ${otp}. It is valid for 5 minutes.`,
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log("✅ OTP sent to:", email);
    return true;
  } catch (error) {
    console.error("❌ Error sending OTP:", error);
    return false;
  }
};

// ✅ Function to Verify OTP
const verifyOTP = async (email, enteredOtp) => {
  const user = await User.findOne({ email });

  if (!user || !user.otp || !user.otpExpiresAt) {
    return { success: false, message: "Invalid request" };
  }

  if (new Date() > user.otpExpiresAt) {
    return { success: false, message: "OTP expired" };
  }

  if (user.otp !== parseInt(enteredOtp)) {
    return { success: false, message: "Incorrect OTP" };
  }

  // Clear OTP after successful verification
  user.otp = null;
  user.otpExpiresAt = null;
  await user.save();

  return { success: true, message: "OTP verified successfully" };
};

module.exports = { sendOTP, verifyOTP };
