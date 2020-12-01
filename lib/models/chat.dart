import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Chat {
  String id, name, avatar, time, lastMessage;
  bool isMessageRead;
  Chat(
      {this.id,
      this.name,
      this.avatar,
      this.isMessageRead = false,
      this.time,
      this.lastMessage});

  Chat.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        name = doc.data()['name'],
        avatar = doc.data()['avatar'],
        isMessageRead = false,
        lastMessage = "Asome mama kijacho",
        time = (doc.data()['time'] as Timestamp).toDate().toString();
}

List<Chat> firestoreToChatList(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) => Chat.fromFirestore(doc)).toList();
}
