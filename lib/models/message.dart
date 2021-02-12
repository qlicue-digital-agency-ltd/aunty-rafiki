import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String text, sender, mediaType, deleteFor, textDelete;
  DateTime time;

  List<dynamic> media;

  bool showDeletedMessage;

  Message(this.text, this.time);

  Message.fromFirestoreData(Map<String, dynamic> data)
      : text = data['text'],
        time = data['time'].toDate(),
        sender = data['user'],
        mediaType = data['mediaType'],
        deleteFor = data['deleteFor'],
        showDeletedMessage = data['showDeletedMessage'],
        textDelete = data['textDelete'],
        media = data['media'];
}

List<Message> firestoreToMessageList(QuerySnapshot snapshot) {
  return snapshot.docs
      .map((doc) => Message.fromFirestoreData(doc.data()))
      .toList();
}
