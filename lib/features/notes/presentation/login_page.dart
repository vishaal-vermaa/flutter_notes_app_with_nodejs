import 'package:flutter/material.dart';
import 'package:note_app/features/auth/presentation/controllers/auth_controller.dart';
import 'controllers/notes_controller.dart';
import 'register_page.dart';
import 'notes_page.dart';

class LoginPage extends StatefulWidget {
  final NotesController notes;
  final AuthController auth;

  const LoginPage({
    super.key,
    required this.auth,
    required this.notes,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (userController.text.isEmpty || passController.text.isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();

    await widget.auth.login(
      userController.text.trim(),
      passController.text.trim(),
    );

    // If no error, go to Notes
    if (widget.auth.error == null && context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => NotesPage(
            controller: widget.notes,
            auth: widget.auth,
          ),
        ),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.auth,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text("Login")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: userController,
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                const SizedBox(height: 20),

                if (widget.auth.error != null)
                  Text(
                    widget.auth.error!,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 10),

                widget.auth.isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.auth.isLoading ? null : _login,
                    child: const Text("Login"),
                  ),
                ),

                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterPage(
                          auth: widget.auth,
                          notes: widget.notes,
                        ),
                      ),
                    );
                  },
                  child: const Text("Don't have an account? Register"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
