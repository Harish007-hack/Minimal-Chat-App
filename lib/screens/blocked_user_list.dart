import 'package:chating_app/custom/chat_user.dart';
import 'package:chating_app/services/auth/login_and_register_firebase.dart';
import 'package:chating_app/services/backend/userstoring_firestore.dart';
import 'package:flutter/material.dart';

class BlockedUserList extends StatefulWidget {
  const BlockedUserList({super.key});

  @override
  State<BlockedUserList> createState() => _BlockedUserListState();
}

class _BlockedUserListState extends State<BlockedUserList> {
  final StoringFirestore _firebase = StoringFirestore();
  final LoginAndRegisterFirebase _firebaseLogOrReg = LoginAndRegisterFirebase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "B L O C K E D",
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
        stream: _firebase
            .getBlockedUsersStream(_firebaseLogOrReg.auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              "AN Error has occured",
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            );
          }
          final userList = snapshot.data!.docs
              .map(
                (e) => e.data(),
              )
              .toList();
          return userList.isEmpty
              ? Center(
                  child: Text(
                    "No Blocked Users",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 20,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) => ChatUser(
                    email: userList[index]['email'],
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: const Text(
                            "Do you want to unblock this user ?",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "No",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _firebase.unBlockingUser(
                                    _firebaseLogOrReg.auth.currentUser!.uid,
                                    userList[index]['id']);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
