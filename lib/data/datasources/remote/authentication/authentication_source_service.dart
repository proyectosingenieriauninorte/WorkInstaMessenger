import 'dart:convert';
import 'package:loggy/loggy.dart';
import 'package:http/http.dart' as http;

import '../../../../domain/models/authentication_user.dart';
import 'i_authentication_source.dart';

class AuthenticationSourceService implements IAuthenticationSource {
  final String apiKey = '1zjCuS';
  final http.Client httpClient;
  final String appName = 'clase202430';
  final String contractKey = 'f82be126-89c4-4e25-80a3-716db9ff7abd';
  final String baseUrl =
      'https://authenticationapp.mangocoast-ed120e36.eastus.azurecontainerapps.io';
  String? token;
  AuthenticationUser?
      _currentUser; // Variable para almacenar el usuario autenticado

  AuthenticationSourceService({http.Client? client})
      : httpClient = client ?? http.Client();

  @override
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "app_name": appName,
        "username": email,
        "password": password,
      }),
    );

    logInfo(response.statusCode);
    if (response.statusCode == 200) {
      logInfo(response.body);
      final data = jsonDecode(response.body);
      token = data['access_token'];
      _currentUser = AuthenticationUser(
        username: email,
        firstName: data['first_name'] ?? email,
        lastName: data['last_name'] ?? email,
        password: password,
      ); // Almacenar la información del usuario autenticado
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }

  @override
  Future<bool> signUp(AuthenticationUser user) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register?contract_key=$contractKey"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": user.username,
        "first_name": user.username,
        "last_name": user.username,
        "password": user.password,
      }),
    );

    logInfo(response.statusCode);
    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logInfo(response.body);
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }

  @override
  Future<bool> logOut() async {
    _currentUser = null; // Limpiar la información del usuario autenticado
    return Future.value(true);
  }

  @override
  AuthenticationUser? getCurrentUser() {
    return _currentUser; // Devolver la información del usuario autenticado
  }
}
