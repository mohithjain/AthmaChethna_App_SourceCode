const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");
const connectDB = require("./config/db");
const blogRoutes = require("./routes/blogRoutes");



dotenv.config();

// Connect to Database with error handling
connectDB().then(() => {
    console.log("🚀 Database connection established");
}).catch((err) => {
    console.error("❌ Database connection failed:", err);
    process.exit(1); // Exit on failure
});

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Debugging Middleware - Log all incoming requests
app.use((req, res, next) => {
    console.log(`➡️  Incoming ${req.method} request to ${req.url}`);
    console.log("📝 Request Body:", req.body);
    next();
});

// Routes
const authRoutes = require("./routes/auth");
app.use("/api/auth", authRoutes);

// User Routes (corrected the path to lowercase)
const userRoutes = require("./routes/userRoutes");
app.use("/api/users", userRoutes);

//User Fetch data from backend
const userFetchRoutes = require("./routes/userFetch");
app.use("/api/user", userFetchRoutes); // ✅ Adding userFetchRoutes

//route for appointment
const appointmentRoutes = require("./routes/appointmentRoutes");
app.use("/api/appointments", appointmentRoutes); // ✅ Ensures appointment routes are loaded

// Debugging: Log all registered routes
app._router.stack.forEach((r) => {
    if (r.route && r.route.path) {
        console.log(`✅ Registered Route: ${r.route.path}`);
    }
});

// Catch-all route for unknown endpoints
app.use((req, res) => {
    res.status(404).json({ message: "❌ Route not found" });
});

// Global Error Handler (optional)
app.use((err, req, res, next) => {
    console.error("🔥 Server Error:", err);
    res.status(500).json({ message: "Internal Server Error" });
});

// Start Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, "0.0.0.0", () => {
    console.log(`🚀 Server running on port ${PORT}`);
});

//blogs
app.use("/api/blogs", blogRoutes);

