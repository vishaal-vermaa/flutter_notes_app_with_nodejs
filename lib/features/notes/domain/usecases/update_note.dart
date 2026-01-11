import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class UpdateNote {
  final NotesRepository repository;
  UpdateNote(this.repository);

  Future<void> call(String id, Note note) {
    return repository.updateNote(id, note);
  }
}
