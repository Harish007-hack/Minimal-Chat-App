import 'package:chating_app/custom/chat_drawer.dart';
import 'package:chating_app/custom/chat_user.dart';
import 'package:chating_app/screens/chat_room.dart';
import 'package:chating_app/services/auth/login_and_register_firebase.dart';
import 'package:chating_app/services/backend/userstoring_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginAndRegisterFirebase _firebaseLogOrReg = LoginAndRegisterFirebase();
  final StoringFirestore _firestore = StoringFirestore();

  void chatRoomnav(chatReciverEmail, chatReciverId) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ChatRoom(
        title: chatReciverEmail,
        reciverId: chatReciverId,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "U S E R",
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _firebaseLogOrReg.signOut(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      drawer: const ChatDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
          stream: _firestore
              .getBlockedUsersStream(_firebaseLogOrReg.auth.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              const Center(
                child: Text("Has an Error"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final blockedUserList = snapshot.data!.docs
                .map(
                  (data) => data.data()['email'],
                )
                .toList();
            return StreamBuilder(
              stream: _firestore.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.docs.isEmpty
                      ? Center(
                          child: Text(
                            "No users found",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final currentUsermail =
                                _firebaseLogOrReg.auth.currentUser!.email;
                            final user = snapshot.data!.docs[index].data();
                            return (currentUsermail != user['email'] &&
                                    !blockedUserList.contains(user['email']))
                                ? InkWell(
                                    onLongPress: () => showModalBottomSheet(
                                      // useSafeArea: true,
                                      context: context,
                                      builder: (context) => SafeArea(
                                        child: Wrap(
                                          children: [
                                            ListTile(
                                              leading: const Icon(Icons.block),
                                              title: const Text("Block"),
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    content: const Text(
                                                      "Would you like to block this user ?",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .tertiary),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          _firestore.addToBlockList(
                                                              _firebaseLogOrReg
                                                                  .auth
                                                                  .currentUser!
                                                                  .uid,
                                                              user['id'],
                                                              user);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .tertiary),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                // _firestore.addToBlockList(
                                                //     user['id'], user);
                                                // Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.cancel),
                                              title: const Text("Cancel"),
                                              onTap: () =>
                                                  Navigator.of(context).pop(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () =>
                                        chatRoomnav(user['email'], user['id']),
                                    child: ChatUser(
                                      email: user['email'],
                                    ),
                                  )
                                : const SizedBox();
                          },
                        );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }),
    );
  }
}
