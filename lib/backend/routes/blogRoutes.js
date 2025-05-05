const express = require("express");
const router = express.Router();
const blogController = require("../controllers/blogController");
const authenticateUser = require("../middleware/authMiddleware"); // Import the middleware

router.post("/create", authenticateUser, blogController.createBlog); // Protect this route
router.get("/all", blogController.getAllBlogs); // No authentication required for getting blogs
router.delete("/:id", authenticateUser, blogController.deleteBlog); // Protect this route

module.exports = router;
