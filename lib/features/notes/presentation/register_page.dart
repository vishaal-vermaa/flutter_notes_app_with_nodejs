import 'package:flutter/material.dart';
import 'package:note_app/features/auth/presentation/controllers/auth_controller.dart';
import 'controllers/notes_controller.dart';

class RegisterPage extends StatefulWidget {
  final AuthController auth;
  final NotesController notes;

  const RegisterPage({
    super.key,
    required this.auth,
    required this.notes,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    await widget.auth.register(
      usernameController.text.trim(),
      passwordController.text.trim(),
    );

    // If no error, go back to Login
    if (widget.auth.error == null && context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.auth,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text("Register")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration:
                  const InputDecoration(labelText: "Username"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration:
                  const InputDecoration(labelText: "Password"),
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
                    onPressed: _register,
                    child: const Text("Create Account"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
