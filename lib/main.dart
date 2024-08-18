import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa firebase_core
import 'package:work_insta_messenger/data/datasources/remote/messages/i_message_source.dart';
import 'package:work_insta_messenger/data/datasources/remote/messages/message_source_service.dart';
import 'package:work_insta_messenger/data/repositories/repository_message.dart';
import 'package:work_insta_messenger/domain/repositories/i_repository_message.dart';
import 'package:work_insta_messenger/domain/use_case/message_usecase.dart';
import 'package:work_insta_messenger/ui/controller/message_controllerr.dart';

import 'data/datasources/remote/authentication/authentication_source_service.dart';
import 'data/datasources/remote/authentication/i_authentication_source.dart';
import 'data/repositories/repository.dart';
import 'domain/repositories/i_repository.dart';
import 'domain/use_case/authentication_usecase.dart';
import 'ui/controller/authentication_controller.dart';

import 'package:work_insta_messenger/config/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put<IAuthenticationSource>(AuthenticationSourceService());
  Get.put<IRepository>(Repository(Get.find()));
  Get.put(AuthenticationUseCase(Get.find()));
  Get.put(AuthenticationController());

  Get.put<IMessageSource>(MessageSourceService());
  Get.put<IRepositoryMessage>(RepositoryMessage(Get.find()));
  Get.put(MessageUseCase(Get.find()));
  Get.put(MessageControllerr());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
