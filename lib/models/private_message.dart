import 'package:cloud_firestore/cloud_firestore.dart';

class PrivateMessage {
  String id, idFrom, idTo, content, mediaType, repliedUID;
  DateTime time;
  DocumentReference reference;

  List<dynamic> media;

  bool showDeletedPrivateMessage;

  PrivateMessage(
      this.id,
      this.reference,
      this.idFrom,
      this.idTo,
      this.content,
      this.media,
      this.mediaType,
      this.repliedUID,
      this.time,
      this.showDeletedPrivateMessage);

  PrivateMessage.fromFirestoreData(DocumentSnapshot doc)
      : id = doc.id,
        reference = doc.reference,
        idFrom = doc.data()['idFrom'],
        idTo = doc.data()['idTo'],
        time = doc.data()['time'].toDate(),
        content = doc.data()['content'],
        mediaType = doc.data()['mediaType'],
        repliedUID = doc.data()['repliedUID'],
        showDeletedPrivateMessage = doc.data()['showDeletedPrivateMessage'],
        media = doc.data()['media'];
}

List<PrivateMessage> firestoreToPrivateMessageList(QuerySnapshot snapshot) {
  return snapshot.docs
      .map((doc) => PrivateMessage.fromFirestoreData(doc))
      .toList();
}
