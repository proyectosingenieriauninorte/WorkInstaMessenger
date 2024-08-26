import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_insta_messenger/domain/repositories/i_repository_message.dart';

class MessageUseCase {
  final IRepositoryMessage _repositoryMessage;

  MessageUseCase(this._repositoryMessage);

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _repositoryMessage.getUserStream();
  }

  Future<void> sendMessage(
      String message, String sender, String receiver) async {
    await _repositoryMessage.sendMessage(message, sender, receiver);
  }

  Stream<QuerySnapshot> getMessages(String sender, String receiver) {
    return _repositoryMessage.getMessages(sender, receiver);
  }

  // //GET INSTANCE OF CHAT SERVICE
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // //GET USER STREAM

  // Stream<List<Map<String, dynamic>>> getUserStream() {
    // return _firestore
    //     .collection('Users')
    //     .snapshots()
    //     .map((snapshots) => snapshots.docs.map((doc) {
    //           final user = doc.data();
    //           return user;
    //         }).toList());
  // }

  // //SEND MESSAGE
  // Future<void> sendMessage(
    //   String message, String sender, String receiver) async {
    // Message newMessage = Message(
    //     message: message,
    //     sender: sender,
    //     receiver: receiver,
    //     time: DateTime.now());

    // List<String> emails = [sender, receiver];
    // emails.sort();

    // String chatRoomId = emails.join('_');

    // await _firestore
    //     .collection('Chats')
    //     .doc(chatRoomId)
    //     .collection('messages')
    //     .add(newMessage.toMap());
  // }

  // //GET MESSAGES
  // Stream<QuerySnapshot> getMessages(String sender, String receiver) {
  //   List<String> emails = [sender, receiver];
  //   emails.sort();

  //   String chatRoomId = emails.join('_');

  //   return _firestore
  //       .collection('Chats')
  //       .doc(chatRoomId)
  //       .collection('messages')
  //       .orderBy('time')
  //       .snapshots()
  //       .map((snapshots) => snapshots);
  // }
}
