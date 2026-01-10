import 'package:flutter/material.dart';

import '../data/datasources/notes_api_datasource.dart';


class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final api = NotesApiDatasource();

  bool isLoading = false;
  String? error;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
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
                    await api.addNote(
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
                },
                child: const Text("Save Note"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
