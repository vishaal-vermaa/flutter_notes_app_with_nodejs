import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;
  Register(this.repository);

  Future<void> call(String username, String password) {
    return repository.register(username, password);
  }
}
