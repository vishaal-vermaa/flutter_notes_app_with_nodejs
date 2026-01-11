import 'package:flutter/material.dart';
import 'controllers/notes_controller.dart';

class AddNotePage extends StatefulWidget {
  final NotesController controller;

  const AddNotePage({super.key, required this.controller});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool isLoading = false;
  String? error;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (titleController.text.isEmpty ||
        contentController.text.isEmpty) {
      setState(() {
        error = "Title and content cannot be empty";
      });
      return;
    }

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      await widget.controller.add(
        titleController.text.trim(),
        contentController.text.trim(),
      );

      // Go back to notes page
      if (context.mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() {
        error = "Failed to add note";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: "Content"),
            ),
            const SizedBox(height: 20),

            if (error != null)
              Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),

            const SizedBox(height: 10),

            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveNote,
                child: const Text("Save Note"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
