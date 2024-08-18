import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';
import 'package:work_insta_messenger/ui/controller/message_controllerr.dart';
import 'package:work_insta_messenger/ui/widgets/custom_drawer.dart';

import '../../controller/authentication_controller.dart';
import '../../widgets/user_tile.dart';

class ContentPage extends StatelessWidget {
  ContentPage({super.key});

  final MessageControllerr messageControllerr = Get.find();

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
        appBar: AppBar(
          title: const Text("Welcome"),
          actions: [
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  _logout();
                })
          ],
        ),
        drawer: const CustomDrawer(),
        body: _builderUserList());
  }

  Widget _builderUserList() {
    return StreamBuilder(
      stream: messageControllerr.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>(
                  (userdata) => _builderUserListItem(userdata, context))
              .toList(),
        );
      },
    );
  }

  Widget _builderUserListItem(Map<String, dynamic> user, BuildContext context) {
    {
      if (user['email'] !=
          Get.find<AuthenticationController>().getCurrentUser()?.username) {
        return UserTile(
          text: user['email'],
          onTap: () {
            GoRouter.of(context).push('/chat/${user['email']}');
          },
        );
      } else {
        return const SizedBox();
      }
    }
  }
}
