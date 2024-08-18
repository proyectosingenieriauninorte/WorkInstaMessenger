import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:loggy/loggy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/authentication_user.dart';
import '../../domain/use_case/authentication_usecase.dart';

class AuthenticationController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final logged = false.obs;

  bool get isLogged => logged.value;

  AuthenticationUser? getCurrentUser() {
    final AuthenticationUseCase authentication = Get.find();
    return authentication.getCurrentUser();
  }

  Future<bool> login(email, password) async {
    final AuthenticationUseCase authentication = Get.find();
    var authResult = await authentication.login(email, password);
    if (authResult) {
      logged.value = true;
      firestore.collection("Users").doc(email).set({
        'email': email, // Guarda el email en la colección Users
      });
    }
    return authResult;
  }

  Future<bool> signUp(email, password) async {
    final AuthenticationUseCase authentication = Get.find();
    logInfo('Controller Sign Up');

    // Llama al método signUp de AuthenticationUseCase y obtiene el resultado
    var authResult = await authentication.signUp(email, password);

    if (authResult) {
      firestore.collection("Users").doc(email).set({
        'email': email, // Guarda el email en la colección Users
      });
    }

    return authResult;
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
