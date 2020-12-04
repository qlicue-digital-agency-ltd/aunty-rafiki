import 'package:aunty_rafiki/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    fetchUsers();
  }
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<User> _availableUsers = [];
  List<User> _originalAvailableUsers = [];
  List<User> _selectedUser = [];
  //getters..
  List<User> get availableUsers => _availableUsers;
  List<User> get originalAvailableUsers => _originalAvailableUsers;
  List<User> get selectedUser => _selectedUser;
  //fetch users...
  Stream<List<User>> availableUserList() {
    return _firebaseFirestore.collection('users').snapshots().map((snapShot) =>
        snapShot.docs
            .map((document) => User.fromMap(document.data()))
            .toList());
  }

  //get user List...
  fetchUsers() async {
    await _firebaseFirestore
        .collection('users')
        .orderBy('displayName')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc);
                User _user = User.fromMap(doc.data());
                _availableUsers.add(_user);
                _originalAvailableUsers.add(_user);
              })
            });

    notifyListeners();
  }

  selectUser({@required int indexAvailableUser, @required User user}) {
    //selected user
    _selectedUser.add(user);

    ///available user
    _availableUsers.removeAt(indexAvailableUser);
    notifyListeners();
  }

  removeUser({@required int indexSelectedUser, @required User user}) {
    //selected user
    _selectedUser.removeAt(indexSelectedUser);

    ///available user
    _availableUsers.add(user);
    notifyListeners();
  }

  clearAllSelectedUsers() {
    _selectedUser.forEach((user) {
      _availableUsers.add(user);
    });
    _selectedUser.clear();
    notifyListeners();
  }
}
