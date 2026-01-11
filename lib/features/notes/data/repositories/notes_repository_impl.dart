import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_api_datasource.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesApiDatasource api;
  NotesRepositoryImpl(this.api);

  @override
  Future<List<Note>> getNotes() async {
    final models = await api.getNotes();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addNote(Note note) {
    return api.addNote(note.title, note.content);
  }

  @override
  Future<void> updateNote(String id, Note note) {
    return api.updateNote(id, note.title, note.content);
  }

  @override
  Future<void> deleteNote(String id) {
    return api.deleteNote(id);
  }
}
