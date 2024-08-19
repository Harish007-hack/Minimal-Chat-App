import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    required this.trailing,
    this.onTap
  });
  final String title;
  final Widget trailing;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 25),
        tileColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
