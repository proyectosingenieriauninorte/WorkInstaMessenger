class Message {
  final String sender;
  final String receiver;
  final String message;
  final DateTime time;

  Message({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'time': time,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      sender: map['sender'],
      receiver: map['receiver'],
      message: map['message'],
      time: map['time'],
    );
  }
}
