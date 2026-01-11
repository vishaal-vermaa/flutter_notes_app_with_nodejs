import 'package:flutter/material.dart';
import 'features/auth/data/datasources/auth_api_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/notes/data/datasources/notes_api_datasource.dart';
import 'features/notes/data/repositories/notes_repository_impl.dart';
import 'features/notes/domain/usecases/add_note.dart';
import 'features/notes/domain/usecases/delete_note.dart';
import 'features/notes/domain/usecases/get_notes.dart';
import 'features/notes/domain/usecases/update_note.dart';
import 'features/notes/presentation/controllers/notes_controller.dart';
import 'myapp.dart';



void main() {
  // Notes
  final api = NotesApiDatasource();
  final repo = NotesRepositoryImpl(api);

  final notesController = NotesController(
    getNotes: GetNotes(repo),
    addNote: AddNote(repo),
    updateNote: UpdateNote(repo),
    deleteNote: DeleteNote(repo),
  );

  // Auth
  final authApi = AuthApiDatasource();
  final authRepo = AuthRepositoryImpl(authApi);
  final authController = AuthController(
    loginUsecase: Login(authRepo),
    registerUsecase: Register(authRepo),
    logoutUsecase: Logout(authRepo),
  );

  runApp(MyApp(
      notesController: notesController,
      authController: authController,
  ));
}


