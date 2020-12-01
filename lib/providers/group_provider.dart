import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class GroupProvider with ChangeNotifier {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  File get pickedImage => _pickedImage;
  File _pickedImage, file;
  //file pickers
  void chooseAmImage() async {
    file = await ImagePicker.pickImage(source: ImageSource.gallery);

    _pickedImage = file;
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  void resetImage() {
    _pickedImage = null;
    notifyListeners();
  }

  //create user group...
  Future<void> uploadGroupIcon({@required groupUUID}) async {
    if (_pickedImage != null) {
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref('uploads/group/' + groupUUID + '.png')
          .putFile(_pickedImage);

      task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
        print('Task state: ${snapshot.state}');
        print(
            'Progress: ${(snapshot.totalBytes / snapshot.bytesTransferred) * 100} %');
      }, onError: (e) {
        // The final snapshot is also available on the task via `.snapshot`,
        // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
        //print(task.snapshot);
        print('User does not have ');
        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
        }
      });
      try {
        // Storage tasks function as a Delegating Future so we can await them.
        final url = await task;

        String photoURL = await url.ref.getDownloadURL();
        //update profile...
        _updateUserGroupIcon(
          avatar: photoURL,
        );
        print('Upload complete.' + photoURL);
      } on firebase_core.FirebaseException catch (e) {
        // The final snapshot is also available on the task via `.snapshot`,
        // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
        print(task.snapshot);

        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
        }
        // ...
      }
    }
  }

//upload file url......
  Future<void> createUserGroup(
      {@required name, @required time, @required members}) async {
    await db.collection('groups').add({
      'name': name,
      'time': time,
      'members': members,
      'messages': [],
      'avatar': ""
    }).then((group) => uploadGroupIcon(groupUUID: group.id));
  }

  //upload file url......
  _updateUserGroupIcon({String groupUUID, String avatar}) {
    db.collection('groups').doc(groupUUID).update({'avatar': avatar});
  }
}
