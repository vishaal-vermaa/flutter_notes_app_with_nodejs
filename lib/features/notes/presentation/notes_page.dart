import 'package:flutter/material.dart';
import 'add_note_page.dart';
import 'controllers/notes_controller.dart';
import 'edit_note_page.dart';
import 'login_page.dart';
import 'package:note_app/features/auth/presentation/controllers/auth_controller.dart';

class NotesPage extends StatefulWidget {
  final NotesController controller;
  final AuthController auth;

  const NotesPage({
    super.key,
    required this.controller,
    required this.auth,
  });

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadNotes(); // ✅ Initial data load
  }

  Future<void> _logout() async {
    await widget.auth.logout(); // ✅ Delegate to AuthController

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => LoginPage(
            auth: widget.auth,
            notes: widget.controller,
          ),
        ),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Notes"),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                tooltip: "Logout",
                onPressed: _logout,
              ),
            ],
          ),

          body: widget.controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : widget.controller.error != null
              ? Center(
            child: Text(
              widget.controller.error!,
              style: const TextStyle(color: Colors.red),
            ),
          )
              : ListView.builder(
            itemCount: widget.controller.notes.length,
            itemBuilder: (_, i) {
              final note = widget.controller.notes[i];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                onTap: () async {
                  final updated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditNotePage(
                        note: note,
                        controller: widget.controller,
                      ),
                    ),
                  );
                  if (updated == true) {
                    widget.controller.loadNotes();
                  }
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () =>
                      widget.controller.delete(note.id),
                ),
              );
            },
          ),

          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AddNotePage(controller: widget.controller),
                ),
              );
              if (added == true) {
                widget.controller.loadNotes();
              }
            },
          ),
        );
      },
    );
  }
}
