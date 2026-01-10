import 'package:flutter/material.dart';

import '../../../core/utils/token_storage.dart';
import '../data/datasources/notes_api_datasource.dart';
import '../data/repositories/notes_repository_impl.dart';
import '../domain/entities/note.dart';
import 'add_note_page.dart';
import 'edit_note_page.dart';
import 'login_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final repo = NotesRepositoryImpl(NotesApiDatasource());
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    notes = await repo.getNotes();
    setState(() {});
  }

  Future<void> _logout() async {
    await TokenStorage.clear(); // 🔐 Clear saved JWT

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: "logout",
          ),
        ]
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(notes[i].title),
          subtitle: Text(notes[i].content),

          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditNotePage(note: notes[i]),
              ),
            );

            // Refresh after edit
            if (result == true) {
              load();
            }
          },

          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await repo.deleteNote(notes[i].id);
              load();
            },
          ),
        ),

      ),

      // 🔥 Add Note Button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNotePage()),
          );

          // If a note was added, refresh list
          if (result == true) {
            load();
          }
        },
      ),
    );

  }
}