import 'package:cloud_firestore/cloud_firestore.dart';

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
        avatar = doc.data()['name'],
        isMessageRead = false,
        lastMessage = "Asome mama kijacho",
        time = DateTime.now().toString();
}

List<Chat> firestoreToChatList(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) => Chat.fromFirestore(doc)).toList();
}
