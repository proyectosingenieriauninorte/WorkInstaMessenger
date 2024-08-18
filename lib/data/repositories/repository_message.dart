import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:work_insta_messenger/data/datasources/remote/messages/i_message_source.dart';
import 'package:work_insta_messenger/domain/repositories/i_repository_message.dart';

class RepositoryMessage implements IRepositoryMessage {
  late IMessageSource messageSource;

  RepositoryMessage(this.messageSource);

  @override
  Stream<QuerySnapshot<Object?>> getMessages(String sender, String receiver) {
    return messageSource.getMessages(sender, receiver);
  }

  @override
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return messageSource.getUserStream();
  }

  @override
  Future<void> sendMessage(
      String message, String sender, String receiver) async {
    return await messageSource.sendMessage(message, sender, receiver);
  }
}
