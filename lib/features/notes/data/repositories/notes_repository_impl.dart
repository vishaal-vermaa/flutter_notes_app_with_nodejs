// TODO: Add notes repository implementation
import '../../domain/entities/note.dart';
import '../datasources/notes_api_datasource.dart';

class NotesRepositoryImpl {
  final NotesApiDatasource api;

  NotesRepositoryImpl(this.api);

  Future<List<Note>> getNotes() async {
    final models = await api.getNotes();
    return models.map((e) => e.toEntity()).toList();
  }

  Future<void> addNote(Note note) {
    return api.addNote(note.title, note.content);
  }

  Future<void> deleteNote(String id) {
    return api.deleteNote(id);
  }
}
