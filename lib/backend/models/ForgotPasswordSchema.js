const mongoose = require("mongoose");

const ForgotPasswordSchema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    unique: true, // One OTP per email at a time
  },
  otp: {
    type: String,
    required: true,
  },
  expiresAt: {
    type: Date,
    required: true,
  },
});

// Automatically delete expired OTPs
ForgotPasswordSchema.index({ expiresAt: 1 }, { expireAfterSeconds: 0 });

const ForgotPassword = mongoose.model("ForgotPassword", ForgotPasswordSchema);
module.exports = ForgotPassword;
