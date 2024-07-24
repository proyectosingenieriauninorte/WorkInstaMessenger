import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_insta_messenger/ui/pages/content/content_page.dart';

import 'controller/authentication_controller.dart';
import 'pages/authentication/login_page.dart';

class Central extends StatelessWidget {
  const Central({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController = Get.find();
    return Obx(() => authenticationController.isLogged
        ? const ContentPage()
        : const LoginPage());
  }
}
