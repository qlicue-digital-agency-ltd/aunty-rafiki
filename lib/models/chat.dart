import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id, name, avatar, time, lastMessage;
  List<dynamic> searchKeywords;
  bool isMessageRead;
  Chat(
      {this.id,
      this.name,
      this.avatar,
      this.isMessageRead = false,
      this.time,
      this.lastMessage,
      this.searchKeywords});

  Chat.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        name = doc.data()['name'],
        avatar = doc.data()['avatar'],
        searchKeywords = doc.data()['searchKeywords'],
        isMessageRead = false,
        lastMessage = "Asome mama kijacho",
        time = (doc.data()['time'] as Timestamp).toDate().toString();
}

List<Chat> firestoreToChatList(QuerySnapshot snapshot) {

  return snapshot.docs.map((doc) => Chat.fromFirestore(doc)).toList();
}

List<Chat> firestoreToChatListFiltered(
    QuerySnapshot snapshot, String textString) {
  return snapshot.docs
      .where((doc) => doc['searchKeywords'].contains(textString))
      .map((doc) => Chat.fromFirestore(doc))
      .toList();
}
