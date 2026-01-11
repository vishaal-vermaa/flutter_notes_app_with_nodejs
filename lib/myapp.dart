import 'package:flutter/material.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/notes/presentation/controllers/notes_controller.dart';
import 'features/notes/presentation/login_page.dart';
import 'features/notes/presentation/notes_page.dart';

class MyApp extends StatefulWidget {
  final NotesController notesController;
  final AuthController authController;

  const MyApp({
    super.key,
    required this.notesController,
    required this.authController,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final loggedIn = await widget.authController.isLoggedIn();
    setState(() {
      isLoggedIn = loggedIn;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return AnimatedBuilder(
      animation: widget.authController,
      builder: (context, _) {
        return MaterialApp(
          home: isLoggedIn
              ? NotesPage(
            controller: widget.notesController,
            auth: widget.authController,
          )
              : LoginPage(
            auth: widget.authController,
            notes: widget.notesController,
          ),
        );
      },
    );
  }
}
