import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id, name,avatar;
  Chat(this.id, this.name, this.avatar);

  Chat.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        name = doc.data()['name'],
        avatar = doc.data()['name'];
}

List<Chat> firestoreToChatList(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) => Chat.fromFirestore(doc)).toList();
}
