import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //Logo
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: size.width * 0.2,
                  ),
                ),
              ),

              //home list
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    //Navigate to Home
                  },
                ),
              ),

              //settings
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    //Navigate to Home
                  },
                ),
              ),
            ],
          ),

          //LogOut
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: () {
                //Navigate to Home
              },
            ),
          ),
        ],
      ),
    );
  }
}
