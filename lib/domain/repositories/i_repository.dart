import '../models/authentication_user.dart';

abstract class IRepository {
  Future<bool> login(String email, String password);

  Future<bool> signUp(AuthenticationUser user);

  Future<bool> logOut();

  AuthenticationUser? getCurrentUser();
}
