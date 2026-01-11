import 'package:flutter/material.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/add_note.dart';
import '../../domain/usecases/update_note.dart';
import '../../domain/usecases/delete_note.dart';

class NotesController extends ChangeNotifier {
  final GetNotes getNotes;
  final AddNote addNote;
  final UpdateNote updateNote;
  final DeleteNote deleteNote;

  NotesController({
    required this.getNotes,
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  });

  List<Note> notes = [];
  bool isLoading = false;
  String? error;

  Future<void> loadNotes() async {
    try {
      isLoading = true;
      notifyListeners();

      notes = await getNotes();
    } catch (e) {
      error = "Failed to load notes";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> add(String title, String content) async {
    await addNote(Note(id: "", title: title, content: content));
    await loadNotes();
  }

  Future<void> update(String id, String title, String content) async {
    await updateNote(id, Note(id: id, title: title, content: content));
    await loadNotes();
  }

  Future<void> delete(String id) async {
    await deleteNote(id);
    await loadNotes();
  }
}
