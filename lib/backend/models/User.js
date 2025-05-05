const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    name: { type: String, required: true },
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    semester: { type: String, required: true },
    department: { type: String, required: true },
    phone: { type: String, required: true, unique: true },
    otp: { type: Number, default: null },
    otpExpiresAt: { type: Date, default: null },
});

const User = mongoose.model("User", userSchema);

module.exports = User;
