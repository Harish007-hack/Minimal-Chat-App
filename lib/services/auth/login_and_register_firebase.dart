import 'package:firebase_auth/firebase_auth.dart';

class LoginAndRegisterFirebase{
  final FirebaseAuth auth =  FirebaseAuth.instance;

  void loginUser(email,password) async{
    final user = await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> registerUser(email,password) async{
    final registerduser = auth.createUserWithEmailAndPassword(email: email, password: password);
    return (registerduser);
  }

  void signOut() async{
    await auth.signOut();
  }

  // void getUsers() {
  //   auth.app.
  // }
}