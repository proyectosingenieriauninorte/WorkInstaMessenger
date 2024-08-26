import '../../../../domain/models/authentication_user.dart';

abstract class IAuthenticationSource {
  Future<bool> login(String username, String password);

  Future<bool> signUp(AuthenticationUser user);

  Future<bool> logOut();

  AuthenticationUser? getCurrentUser();
}
