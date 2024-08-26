import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_insta_messenger/ui/controller/authentication_controller.dart';

import '../../controller/message_controllerr.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;

  ChatPage({super.key, required this.receiverEmail});

  //text controllerr
  final TextEditingController _textMessageController = TextEditingController();

  //message service
  final MessageControllerr messageControllerr = Get.find();

  final AuthenticationController authenticationController = Get.find();

  //SEND MESSAGE
  void _sendMessage() async {
    final String sender = authenticationController.getCurrentUser()!.username;
    final String message = _textMessageController.text;

    if (_textMessageController.text.isNotEmpty) {
      await messageControllerr.sendMessage(message, sender, receiverEmail);
      _textMessageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(receiverEmail),
        ),
        body: Column(
          children: [
            //All messages
            Expanded(child: _buildMessageList()),

            //Message input
            _buildMessageInput(),
          ],
        ));
  }

  //build message list
  Widget _buildMessageList() {
    String sender = authenticationController.getCurrentUser()!.username;
    return StreamBuilder(
      stream: messageControllerr.getMessages(sender, receiverEmail),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        //list of messages
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((e) => _buildMessageItem(e))
              .toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(e) {
    Map<String, dynamic> data = e.data() as Map<String, dynamic>;

    //is Current user
    bool isCurrentUser =
        authenticationController.getCurrentUser()!.username == data['sender'];

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start, //align message
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: isCurrentUser ? Colors.blue : Colors.grey,
                //!! Important change the color of theme color
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              data['message'],
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textMessageController,
            decoration: const InputDecoration(hintText: "Enter message"),
          ),
        ),
        IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              _sendMessage();
            })
      ],
    );
  }
}
