const express = require("express");
const User = require("../models/User"); // Importing User model
const router = express.Router();

// ✅ Fetch User Data by ID (including decrypted password)
router.get("/:userId", async (req, res) => {
  console.log("🔍 Received userId:", req.params.userId);
  const { userId } = req.params;

  try {
    const user = await User.findById(userId).select("name username email department semester phone");
    if (!user) {
        console.log("User not found!");
        return res.status(404).json({ message: "User not found" });
    }

    console.log("User Data Fetched:", user);

    res.status(200).json({
        user : {
            name: user.name,
            username: user.username,
            email: user.email,
            department: user.department,
            semester: user.semester,
            phone: user.phone,
        }
    });
  } catch (error) {
    console.error("❌ Error fetching user data:", error);
    res.status(500).json({ message: "Failed to fetch user data", error: error.message });
  }
});

module.exports = router;
