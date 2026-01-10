import 'package:flutter/material.dart';
import 'package:note_app/features/notes/presentation/register_page.dart';

import '../../auth/data/datasources/auth_api_datasource.dart';
import 'notes_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authApi = AuthApiDatasource();
  final userController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: userController, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: passController, decoration: const InputDecoration(labelText: "Password")),
            ElevatedButton(
              onPressed: () async {
                await authApi.login(userController.text, passController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotesPage()),
                );
              },
              child: const Text("Login"),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                );
              },
              child: const Text("Don't have an account? Register"),
            ),

          ],
        ),
      ),
    );
  }
}