import mongoose from "mongoose";

const noteSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
  title: String,
  content: String
});

// module.exports = mongoose.model("Note", noteSchema);

export default mongoose.model("Note", noteSchema);