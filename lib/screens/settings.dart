import 'package:chating_app/custom/settings_tile.dart';
import 'package:chating_app/screens/blocked_user_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatSettings extends StatefulWidget {
  const ChatSettings({super.key});

  @override
  State<ChatSettings> createState() => _ChatSettingsState();
}

class _ChatSettingsState extends State<ChatSettings> {
  bool light = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'U S E R',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SettingsTile(
              title: 'Dark Mode',
              trailing: CupertinoSwitch(
                value: true,
                onChanged: (value) => null,
              )),
          SettingsTile(
            title: 'Blocked Users',
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BlockedUserList(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
