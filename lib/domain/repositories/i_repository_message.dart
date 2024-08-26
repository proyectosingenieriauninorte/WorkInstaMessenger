import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IRepositoryMessage {
  Stream<List<Map<String, dynamic>>> getUserStream();

  Future<void> sendMessage(String message, String sender, String receiver);

  Stream<QuerySnapshot> getMessages(String sender, String receiver);
}
