import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id, text, sender, senderName, mediaType, repliedUID;
  DateTime time;

  List<dynamic> media;

  bool showDeletedMessage;

  Message(this.text, this.time);

  Message.fromFirestoreData(DocumentSnapshot doc)
      : id = doc.id,
        text = doc.data()['text'],
        time = doc.data()['time'].toDate(),
        sender = doc.data()['user'],
        senderName = doc.data()['senderName'],
        mediaType = doc.data()['mediaType'],
        repliedUID = doc.data()['repliedUID'],
        showDeletedMessage = doc.data()['showDeletedMessage'],
        media = doc.data()['media'];
}

List<Message> firestoreToMessageList(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) => Message.fromFirestoreData(doc)).toList();
}
