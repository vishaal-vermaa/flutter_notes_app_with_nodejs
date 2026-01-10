import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const MONGODB_URL = process.env.MONGODB_URI;
console.log("MongoDB URI:", MONGODB_URL);

app.get('/', (req, res) => {
    res.send("Api is running...");
});


import authRoutes from './routes/auth.js';
import notesRoutes from './routes/notes.js';

app.use('/notes', notesRoutes);
app.use('/auth', authRoutes);

// Connect to MongoDB
mongoose.connect(MONGODB_URL)
    .then(() => console.log('MongoDB connected'))
    .catch(err => console.log(err));

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});