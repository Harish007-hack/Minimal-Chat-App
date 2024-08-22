import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    //request user to allow notification
    await _firebaseMessaging.requestPermission();
    //fetch FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();
    //print the token
    print(fCMToken);

    // initNotifications();
  }

  // Future initPushNotification() async {
  //   FirebaseMessaging.instance.getInitialMessage().then((value) => print(value),);
  //   FirebaseMessaging.onMessageOpenedApp.listen(print);
  // }

}