import 'package:flutter/material.dart';

class ChatUser extends StatelessWidget {
  const ChatUser({super.key, required this.email,this.onLongPress});
  final String email;
  final void Function()? onLongPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        tileColor: Theme.of(context).colorScheme.primary,
        leading: Icon(Icons.person,color: Theme.of(context).colorScheme.tertiary,),
        title: Text(email,style: const TextStyle(fontSize: 15),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onLongPress: onLongPress,
      ),
    );
  }
}
