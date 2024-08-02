import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'data/datasources/remote/authentication/authentication_source_service.dart';
import 'data/datasources/remote/authentication/i_authentication_source.dart';
import 'data/repositories/repository.dart';
import 'domain/repositories/i_repository.dart';
import 'domain/use_case/authentication_usecase.dart';
import 'ui/central.dart';
import 'ui/controller/authentication_controller.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura que los bindings de widgets están inicializados.

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put<IAuthenticationSource>(AuthenticationSourceService());
  Get.put<IRepository>(Repository(Get.find()));
  Get.put(AuthenticationUseCase(Get.find()));
  Get.put(AuthenticationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Central(),
    );
  }
}
