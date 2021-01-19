import 'dart:io';

import 'package:aunty_rafiki/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/services.dart';

class GroupProvider with ChangeNotifier {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool _isCreatingGroup = false;

  List<PlatformFile> _paths = [];
  bool _loadingPath = false;

  // List<String> _members = [];

  // //setters
  // set addMember(String memberUID) {
  //   _members.add(memberUID);
  //   notifyListeners();
  // }

  //getters....
  // List<String> get members => _members;
  bool get isCreatingGroup => _isCreatingGroup;
  List<File> get files => _paths.map((path) => File(path.path)).toList();
  bool get loadingPath => _loadingPath;

  Future<void> openFileExplorer() async {
    _loadingPath = true;
    notifyListeners();

    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        allowedExtensions: null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    notifyListeners();
  }

  void resetImage() {
    _paths = [];
    notifyListeners();
  }

  //create user group...
  Future<void> uploadGroupIcon({@required groupUUID}) async {
    if (files.isNotEmpty) {
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref('uploads/group/' + groupUUID + '.png')
          .putFile(files[0]);

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
          groupUID: groupUUID,
        );
        print('Upload complete.' + photoURL);
        _isCreatingGroup = false;
        notifyListeners();
      } on firebase_core.FirebaseException catch (e) {
        // The final snapshot is also available on the task via `.snapshot`,
        // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
        print(task.snapshot);

        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
        }
        // ...
      }
    } else {
      _isCreatingGroup = false;
      notifyListeners();
    }
  }

//upload file url......
  Future<void> createUserGroup(
      {@required name,
      @required time,
      @required List<User> groupMembers}) async {
    List<String> _searchKeywords = [];
    List<String> _members = [];

    groupMembers.forEach((member) {
      _members.add(member.uid);
    });
    var character = "";
    name.runes.forEach((int rune) {
      character += String.fromCharCode(rune);
      _searchKeywords.add(character);
      print(character);
    });

    _isCreatingGroup = true;
    notifyListeners();
    await db.collection('groups').add({
      'name': name,
      'time': time,
      'members': _members,
      'messages': [],
      'searchKeywords': _searchKeywords,
      'avatar': ""
    }).then((group) {
      uploadGroupIcon(groupUUID: group.id);
      notifyListeners();
    });
  }

  //upload file url......
  _updateUserGroupIcon({@required String groupUID, @required String avatar}) {
    db.collection('groups').doc(groupUID).update({'avatar': avatar});
  }

  leaveGroup({@required String groupUID, @required String memberUID}) {
    db.collection('groups').doc(groupUID).update({
      'members': FieldValue.arrayRemove([memberUID])
    });
  }
}
