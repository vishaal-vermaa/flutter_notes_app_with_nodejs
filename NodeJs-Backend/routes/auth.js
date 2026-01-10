import express from 'express';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import User from '../models/User.js';   

const router = express.Router();

// Register
router.post('/register', async (req, res) => {
    const { username, password } = req.body;

    const hashedPassword = await bcrypt.hash(password, 10);
    const user = new User({ username, password: hashedPassword});
    await user.save();

    res.json({ message: "User registered successfully" });
});

// Login
router.post('/login', async (req, res) => {
    const { username, password } = req.body;

    const user= await User.findOne({ username });
    if (!user) {
        return res.status(400).json({ message: "User not found" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) return res.status(400).json({ message: "Invalid password" });

  const token = jwt.sign({ id: user._id }, "SECRET_KEY");
  res.json({ token });
});

// module.exports = router;
export default router;
