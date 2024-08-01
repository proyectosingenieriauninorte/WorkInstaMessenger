import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import '../../domain/use_case/authentication_usecase.dart';

class AuthenticationController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final logged = false.obs;

  bool get isLogged => logged.value;

  Future<bool> login(email, password) async {
    final AuthenticationUseCase authentication = Get.find();
    var rta = await authentication.login(email, password);
    if (rta) {
      logged.value = true;
    }
    return rta;
  }

  Future<bool> signUp(email, password) async {
    final AuthenticationUseCase authentication = Get.find();
    logInfo('Controller Sign Up');
    await authentication.signUp(email, password);
    return true;
  }

  Future<void> logOut() async {
    logged.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool wasLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (wasLoggedIn) {
      bool didAuthenticate = await authenticateWithBiometrics();
      logged.value = didAuthenticate;
    } else {
      logged.value = false;
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      return authenticated;
    } catch (e) {
      logError('Biometric authentication failed: $e');
      return false;
    }
  }
}
