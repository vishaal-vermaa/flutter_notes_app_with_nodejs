import 'package:flutter/material.dart';
import '../../../../core/utils/token_storage.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/logout.dart';

class AuthController extends ChangeNotifier {
  final Login loginUsecase;
  final Register registerUsecase;
  final Logout logoutUsecase;

  bool isLoading = false;
  String? error;

  AuthController({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
  });

  Future<void> login(String username, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await loginUsecase(username, password);
    } catch (e) {
      error = "Invalid username or password";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String username, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await registerUsecase(username, password);
    } catch (e) {
      error = "Registration failed";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await logoutUsecase();
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    final token = await TokenStorage.get();
    return token != null;
  }


}
