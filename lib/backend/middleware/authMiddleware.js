const jwt = require('jsonwebtoken');
const User = require('../models/User'); // Assuming you have a User model

// Middleware to check if the user is authenticated
const authenticateUser = async (req, res, next) => {
    const token = req.header('Authorization')?.replace('Bearer ', '');

    if (!token) {
        return res.status(401).json({ message: "Authorization token required" });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET); // JWT secret key
        const user = await User.findById(decoded.userId); // Decode user ID from the token

        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        req.user = user; // Add user to the request object
        next(); // Proceed to the next middleware or route handler
    } catch (err) {
        res.status(401).json({ message: "Invalid or expired token", error: err.message });
    }
};

module.exports = authenticateUser;
