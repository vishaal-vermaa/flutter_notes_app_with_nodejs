// TODO: Add notes API datasource implementation
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/token_storage.dart';
import '../models/note_model.dart';

class NotesApiDatasource {
  Future<List<NoteModel>> getNotes() async {
    final token = await TokenStorage.get();

    final response = await http.get(
      Uri.parse("${ApiConstants.baseUrl}/notes"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    final List data = jsonDecode(response.body);
    return data.map((e) => NoteModel.fromJson(e)).toList();
  }

  Future<void> addNote(String title, String content) async {
    final token = await TokenStorage.get();

    await http.post(
      Uri.parse("${ApiConstants.baseUrl}/notes"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"title": title, "content": content}),
    );
  }

  Future<void> deleteNote(String id) async {
    final token = await TokenStorage.get();

    await http.delete(
      Uri.parse("${ApiConstants.baseUrl}/notes/$id"),
      headers: {"Authorization": "Bearer $token"},
    );
  }

  Future<void> updateNote(String id, String title, String content) async {
    final token = await TokenStorage.get();

    await http.put(
      Uri.parse("${ApiConstants.baseUrl}/notes/$id"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "title": title,
        "content": content,
      }),
    );
  }

}
