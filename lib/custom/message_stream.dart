import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageStream extends StatelessWidget {
  const MessageStream({super.key, required this.stream});
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("An Error has Occured"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: snapshot.data!.docs.map(
              (e) {
                final condition = e.data()['senderEmail'] ==
                            FirebaseAuth.instance.currentUser!.email!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: e.data()['senderEmail'] ==
                            FirebaseAuth.instance.currentUser!.email!
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: e.data()['senderEmail'] ==
                                FirebaseAuth.instance.currentUser!.email!
                            ? Colors.green
                            : Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(25),
                          topRight: condition ? Radius.zero : const Radius.circular(25),
                          topLeft: condition ? const Radius.circular(25) : Radius.zero,
                          bottomRight: const Radius.circular(25),
                          
                        ),
                      ),
                      // color: Colors.amber,
                      child: Text(
                        "${e.data()['message']}",
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
