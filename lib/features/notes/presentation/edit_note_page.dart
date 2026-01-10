import 'package:flutter/material.dart';

import '../data/datasources/notes_api_datasource.dart';
import '../domain/entities/note.dart';

class EditNotePage extends StatefulWidget {
  final Note note;

  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  final api = NotesApiDatasource();

  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note")),
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
              Text(error!, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 10),

            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
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
                    await api.updateNote(
                      widget.note.id,
                      titleController.text.trim(),
                      contentController.text.trim(),
                    );

                    // Go back and signal refresh
                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  } catch (e) {
                    setState(() {
                      error = "Failed to update note";
                    });
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: const Text("Update Note"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
