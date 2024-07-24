import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../controller/authentication_controller.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  _logout() async {
    AuthenticationController authenticationController = Get.find();
    try {
      await authenticationController.logOut();
    } catch (e) {
      logInfo(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome"), actions: [
        IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            })
      ]),
      body: const Center(
        child: Text('Content Page'),
      ),
    );
  }
}
