import 'package:work_insta_messenger/domain/models/authentication_user.dart';

import '../../domain/repositories/i_repository.dart';
import '../datasources/remote/authentication/i_authentication_source.dart';

class Repository implements IRepository {
  late IAuthenticationSource authenticationSource;

  Repository(this.authenticationSource);

  @override
  Future<bool> login(String email, String password) async =>
      await authenticationSource.login(email, password);

  @override
  Future<bool> logOut() async => await authenticationSource.logOut();

  @override
  Future<bool> signUp(AuthenticationUser user) =>
      authenticationSource.signUp(user);

  @override
  AuthenticationUser? getCurrentUser() {
    return authenticationSource.getCurrentUser();
  }
}
