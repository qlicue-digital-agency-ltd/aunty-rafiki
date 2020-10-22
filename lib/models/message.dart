import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String text;
  DateTime time;
  String sender;
  List<String> media;

  Message(this.text, this.time);

  Message.fromFirestoreData(Map<String, dynamic> data)
      : text = data['text'],
        time = data['time'].toDate(),
        sender = data['user'],
        media = data['media'];
}

List<Message> firestoreToMessageList(QuerySnapshot snapshot) {
  return snapshot.docs
      .map((doc) => Message.fromFirestoreData(doc.data()))
      .toList();
}
