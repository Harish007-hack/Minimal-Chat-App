import 'package:chating_app/custom/drawer_tile.dart';
import 'package:chating_app/screens/settings.dart';
import 'package:chating_app/services/auth/login_and_register_firebase.dart';
import 'package:flutter/material.dart';

class ChatDrawer extends StatefulWidget {
  const ChatDrawer({super.key});

  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  final LoginAndRegisterFirebase _firebaseLogOrReg = LoginAndRegisterFirebase();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.message_rounded,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              DrawerTile(
                title: 'Home',
                icon: Icons.home,
                onTap: () => Navigator.of(context).pop(),
              ),
              DrawerTile(
                title: 'Settings',
                icon: Icons.settings,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChatSettings(),
                  ));
                },
              ),
            ],
          ),
          DrawerTile(title: 'Logout', icon: Icons.logout,onTap: () {
            _firebaseLogOrReg.signOut();
          },)
        ],
      ),
    );
  }
}
