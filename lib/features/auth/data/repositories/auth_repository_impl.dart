import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDatasource api;
  AuthRepositoryImpl(this.api);

  @override
  Future<void> login(String username, String password) {
    return api.login(username, password);
  }

  @override
  Future<void> register(String username, String password) {
    return api.register(username, password);
  }

  @override
  Future<void> logout() {
    return api.logout();
  }
}
