import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_insta_messenger/data/datasources/remote/messages/i_message_source.dart';
import 'package:work_insta_messenger/domain/models/message.dart';

class MessageSourceService implements IMessageSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Object?>> getMessages(String sender, String receiver) {
    List<String> emails = [sender, receiver];
    emails.sort();

    String chatRoomId = emails.join('_');

    return _firestore
        .collection('Chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .map((snapshots) => snapshots);
  }

  @override
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore
        .collection('Users')
        .snapshots()
        .map((snapshots) => snapshots.docs.map((doc) {
              final user = doc.data();
              return user;
            }).toList());
  }

  @override
  Future<void> sendMessage(
      String message, String sender, String receiver) async {
    Message newMessage = Message(
        message: message,
        sender: sender,
        receiver: receiver,
        time: DateTime.now());

    List<String> emails = [sender, receiver];
    emails.sort();

    String chatRoomId = emails.join('_');

    await _firestore
        .collection('Chats')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }
}
