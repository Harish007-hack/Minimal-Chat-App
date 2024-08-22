import 'package:chating_app/firebase_options.dart';
import 'package:chating_app/screens/home_screen.dart';
import 'package:chating_app/screens/login_screen.dart';
import 'package:chating_app/services/auth/login_and_register_firebase.dart';
import 'package:chating_app/services/backend/push_notification_service.dart';
import 'package:chating_app/services/theme/dark.dart';
import 'package:chating_app/services/theme/light.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PushNotificationService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    final LoginAndRegisterFirebase _firebaseLogOrReg = LoginAndRegisterFirebase();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatting App',
      theme: light,
      darkTheme: dark,
      home: StreamBuilder(stream: _firebaseLogOrReg.auth.authStateChanges(),builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(body: CircularProgressIndicator(),);
        }
        if(snapshot.hasData){
          return const HomeScreen();
        }
        return const LoginScreen();
      },),
    );
  }
}
