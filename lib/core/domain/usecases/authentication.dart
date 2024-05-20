import 'package:vachak/core/data/models/auth_user_model.dart';
import 'package:vachak/core/domain/repositories/user_repository.dart';

class AuthenticationUseCase {
  final UserRepository _userRepository;

  AuthenticationUseCase(this._userRepository);

  Future<AuthUserModel> authenticateUser(String email, String password) async {
    return await _userRepository.authenticateUser(email, password);
  }
}
