import 'package:chating_app/custom/message_stream.dart';
import 'package:chating_app/services/backend/chatmessage_storing.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key, required this.title, required this.reciverId});
  final String title;
  final String reciverId;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final ChatMessageStoring message = ChatMessageStoring();
  final TextEditingController sendTextController = TextEditingController();

  void sendMessages() async {
    if (sendTextController.text.isNotEmpty) {
      await message.sendMessage(widget.reciverId, sendTextController.text);
      sendTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(widget.title,style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child:
                  MessageStream(stream: message.getMessages(widget.reciverId)),
              // child: Container(
              //   width: double.infinity,
              //   child:
              // ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: sendTextController,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.primary,
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () => sendMessages(),
                    icon: const Icon(Icons.send_rounded),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Send a Message",
                ),
              ),
            ),
          ],
        ));
  }
}
