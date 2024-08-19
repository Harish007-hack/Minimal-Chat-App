import 'package:cloud_firestore/cloud_firestore.dart';

class StoringFirestore{
  final FirebaseFirestore backendstore = FirebaseFirestore.instance;

  //creating user
  Future<void> setUserDetails(docId,data) async{
    await backendstore.collection("Users").doc(docId).set(data);
  }

  // retriving user
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return backendstore.collection("Users").snapshots();
  }

  //blocking a user
  void addToBlockList(userId,docId,data) async{
    backendstore.collection('Users').doc(userId).collection('Blocked').doc(docId).set(data);
  }

  //to unblock a user
  void unBlockingUser(userId,docId) {
    backendstore.collection('Users').doc(userId).collection('Blocked').doc(docId).delete();
  }

  //get Blocked User stream 
  Stream<QuerySnapshot<Map<String, dynamic>>> getBlockedUsersStream(userId) {
    return backendstore.collection('Users').doc(userId).collection('Blocked').snapshots();
  }

  // Future<bool> getBlockedUser(docId) async {
  //   final user = await backendstore.collection('Blocked').doc(docId).get();
  //   return user.data() != null ? true: false;
  // }

}