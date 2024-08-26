import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:work_insta_messenger/domain/use_case/message_usecase.dart';

class MessageControllerr extends GetxController {
  Stream<List<Map<String, dynamic>>> getUserStream() {
    final MessageUseCase messageUseCase = Get.find();
    return messageUseCase.getUserStream();
  }

  //SEND MESSAGE
  Future<void> sendMessage(
      String message, String sender, String receiver) async {
    final MessageUseCase messageUseCase = Get.find();
    await messageUseCase.sendMessage(message, sender, receiver);
  }

  //GET MESSAGES
  Stream<QuerySnapshot> getMessages(String sender, String receiver) {
    final MessageUseCase messageUseCase = Get.find();
    return messageUseCase.getMessages(sender, receiver);
  }
}
