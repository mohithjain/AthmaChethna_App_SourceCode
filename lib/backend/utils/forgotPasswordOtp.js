const nodemailer = require("nodemailer");
const ForgotPassword = require("../models/ForgotPasswordSchema");

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.SMTP_EMAIL,
    pass: process.env.SMTP_PASSWORD,
  },
});

// ✅ Generate & Store OTP for Forgot Password
const sendForgotPasswordOTP = async (email) => {
  const otp = Math.floor(1000 + Math.random() * 9000).toString();
  const otpExpiresAt = new Date(Date.now() + 5 * 60 * 1000); // 5 min expiration

  try {
    // Store OTP in the new ForgotPassword schema
    await ForgotPassword.findOneAndUpdate(
      { email },
      { otp, expiresAt: otpExpiresAt },
      { upsert: true, new: true }
    );

    // Email OTP to user
    const mailOptions = {
      from: process.env.SMTP_EMAIL,
      to: email,
      subject: "Your OTP for Password Reset",
      text: `Your OTP code is: ${otp}. It is valid for 5 minutes.`,
    };

    await transporter.sendMail(mailOptions);
    console.log("✅ OTP sent for password reset:", email);
    return { success: true, message: "OTP sent to email" };
  } catch (error) {
    console.error("❌ Error sending OTP:", error);
    return { success: false, message: "Failed to send OTP" };
  }
};

// ✅ Verify OTP for Forgot Password
const verifyForgotPasswordOTP = async (email, enteredOtp) => {
  console.log("📢 Verifying OTP for:", email);
  console.log("🔎 Entered OTP:", enteredOtp);

  const record = await ForgotPassword.findOne({ email });

  if (!record || !record.otp || !record.expiresAt) {
    console.log("❌ Invalid request: No OTP found for this email");
    return { success: false, message: "Invalid request" };
  }

  // Check if OTP is expired
  if (new Date() > record.expiresAt) {
    console.log("⏳ OTP expired");
    return { success: false, message: "OTP expired" };
  }

  // Compare OTP (convert to integer before comparison)
  if (parseInt(record.otp) !== parseInt(enteredOtp)) {
    console.log("❌ Incorrect OTP: Expected", record.otp, "but got", enteredOtp);
    return { success: false, message: "Incorrect OTP" };
  }

  // ✅ OTP verified, now delete the record
  await ForgotPassword.deleteOne({ email });

  console.log("✅ OTP verified successfully");
  return { success: true, message: "OTP verified successfully" };
};

module.exports = { sendForgotPasswordOTP, verifyForgotPasswordOTP };
