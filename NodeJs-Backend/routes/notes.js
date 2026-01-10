import express from "express";
import Note from "../models/Note.js";
import jwt from "jsonwebtoken";

const router = express.Router();

// Middleware to verify token
function auth(req, res, next) {
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) return res.status(401).json({ message: "No token" });

  try {
    const decoded = jwt.verify(token, "SECRET_KEY");
    req.userId = decoded.id;
    next();
  } catch {
    res.status(401).json({ message: "Invalid token" });
  }
}

// Get notes
router.get("/", auth, async (req, res) => {
  const notes = await Note.find({ userId: req.userId });
  res.json(notes);
});

// Add note
router.post("/", auth, async (req, res) => {
  const { title, content } = req.body;

  const note = new Note({
    title,
    content,
    userId: req.userId
  });

  await note.save();
  res.json(note);
});

// Delete note
router.delete("/:id", auth, async (req, res) => {
  await Note.findByIdAndDelete(req.params.id);
  res.json({ message: "Note deleted" });
});

// Update note
router.put("/:id", auth, async (req, res) => {
  const { title, content } = req.body;

  const updated = await Note.findByIdAndUpdate(
    req.params.id,
    { title, content },
    { new: true }
  );

  res.json(updated);
});


// module.exports = router;
export default router;
