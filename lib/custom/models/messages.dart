import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  const Messages({
    required this.senderId,
    required this.senderEmail,
    required this.reciverId,
    required this.message,
    required this.timeStamp,
  });
  final String message;
  final String senderId;
  final String senderEmail;
  final String reciverId;
  final Timestamp timeStamp;

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'reciverId': reciverId,
      'message': message,
      'timestamp': timeStamp,
    };
  }
}
