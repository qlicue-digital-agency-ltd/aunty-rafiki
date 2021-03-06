import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String text;
  DateTime time;
  String sender;
  List<dynamic> media;
  String mediaType;

  Message(this.text, this.time);

  Message.fromFirestoreData(Map<String, dynamic> data)
      : text = data['text'],
        time = data['time'].toDate(),
        sender = data['user'],
        mediaType = data['mediaType'],
        media = data['media'];
}

List<Message> firestoreToMessageList(QuerySnapshot snapshot) {
  return snapshot.docs
      .map((doc) => Message.fromFirestoreData(doc.data()))
      .toList();
}
