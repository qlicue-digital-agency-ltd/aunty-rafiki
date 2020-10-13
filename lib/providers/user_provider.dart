import 'package:aunty_rafiki/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserProvider {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //getters..

  //fetch users...
  Stream<List<User>> availableUserList() {
    return _firebaseFirestore.collection('users').snapshots().map((snapShot) =>
        snapShot.docs
            .map((document) => User.fromMap(document.data()))
            .toList());
  }
}
