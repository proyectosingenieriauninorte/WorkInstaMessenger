import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_insta_messenger/ui/pages/content/content_page.dart';
import '../../controller/authentication_controller.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController(text: 'a@a.com');
  final controllerPassword = TextEditingController(text: '123456');
  AuthenticationController authenticationController = Get.find();
  bool _stayLoggedIn = false;

  // Verificar el estado de login antes de iniciar la aplicación
  AuthenticationController authController = Get.find();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await authController.checkLoginStatus();
    if (authController.isLogged) {
      // Asegúrate de navegar a ContentPage correctamente
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ContentPage()),
      );
    }
  }

  _login(theEmail, thePassword) async {
    logInfo('_login $theEmail $thePassword');
    try {
      await authenticationController.login(theEmail, thePassword);
      if (_stayLoggedIn) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
      }
    } catch (err) {
      Get.snackbar(
        "Login",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        margin: const EdgeInsets.all(10),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Login with email",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: controllerEmail,
                      decoration:
                          const InputDecoration(labelText: "Email address"),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        } else if (!value.contains('@')) {
                          return "Enter valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: controllerPassword,
                      decoration: const InputDecoration(labelText: "Password"),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Enter password";
                        } else if (value.length < 6) {
                          return "Password should have at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CheckboxListTile(
                      title: const Text('Mantenerme conectado'),
                      value: _stayLoggedIn,
                      onChanged: (bool? value) {
                        setState(() {
                          _stayLoggedIn = value!;
                        });
                      },
                    ),
                    OutlinedButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final form = _formKey.currentState;
                          form!.save();
                          if (_formKey.currentState!.validate()) {
                            await _login(
                                controllerEmail.text, controllerPassword.text);
                          }
                        },
                        child: const Text("Submit")),
                  ]),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: const Text("Create account"))
          ],
        ),
      ),
    );
  }
}
