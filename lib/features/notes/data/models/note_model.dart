// TODO: Add note model implementation
import '../../domain/entities/note.dart';

class NoteModel {
  final String id;
  final String title;
  final String content;

  NoteModel({required this.id, required this.title, required this.content});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Note toEntity() => Note(id: id, title: title, content: content);
}
