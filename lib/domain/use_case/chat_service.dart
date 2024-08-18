import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  //GET INSTANCE OF CHAT SERVICE
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //GET USER STREAM

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore
        .collection('Users')
        .snapshots()
        .map((snapshots) => snapshots.docs.map((doc) {
              final user = doc.data();
              return user;
            }).toList());
  }
}
