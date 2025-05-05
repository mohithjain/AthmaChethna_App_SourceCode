const Blog = require("../models/Blog");

// Create blog
exports.createBlog = async (req, res) => {
    try {
        const { title, content } = req.body;
        const author = req.user.username; // Get the username of the logged-in user

        const blog = new Blog({ title, content, author });
        await blog.save();
        res.status(201).json(blog);
    } catch (err) {
        res.status(500).json({ message: "Failed to create blog", error: err.message });
    }
};

// Get all blogs
exports.getAllBlogs = async (req, res) => {
    try {
        const blogs = await Blog.find().sort({ timestamp: -1 });
        res.status(200).json(blogs);
    } catch (err) {
        res.status(500).json({ message: "Failed to fetch blogs", error: err.message });
    }
};

// Delete blog
exports.deleteBlog = async (req, res) => {
    try {
        const blogId = req.params.id;
        await Blog.findByIdAndDelete(blogId);
        res.status(200).json({ message: "Blog deleted successfully" });
    } catch (err) {
        res.status(500).json({ message: "Failed to delete blog", error: err.message });
    }
};
