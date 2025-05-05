const express = require("express");
const User = require("../models/User");
const router = express.Router();

// ✅ Fetch User Details by userId
router.get("/:userId", async (req, res) => {
    const { userId } = req.params;

    try {
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        res.status(200).json({
            message: "User details fetched successfully",
            userId: user._id,
            name: user.name,
            username: user.username,
            email: user.email,
            semester: user.semester,
            department: user.department,
            phone: user.phone
        });
    } catch (error) {
        console.error("❌ Error fetching user details:", error);
        res.status(500).json({ message: "Error fetching user details" });
    }
});

// ✅ Create a New User
router.post("/register", async (req, res) => {
    const { name, username, password, email, semester, department, phone } = req.body;

    try {
        // Check if user already exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: "User already exists" });
        }

        // Create new user
        const newUser = new User({ name, username, password, email, semester, department, phone });
        await newUser.save();

        res.status(201).json({ message: "User registered successfully" });
    } catch (error) {
        console.error("❌ Error registering user:", error);
        res.status(500).json({ message: "Error registering user" });
    }
});

// ✅ User Login
router.post("/login", async (req, res) => {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        // Check password (plain text comparison for simplicity)
        if (user.password !== password) {
            return res.status(401).json({ message: "Invalid credentials" });
        }

        res.status(200).json({ message: "Login successful", userId: user._id });
    } catch (error) {
        console.error("❌ Login Error:", error);
        res.status(500).json({ message: "Login failed" });
    }
});



module.exports = router;
