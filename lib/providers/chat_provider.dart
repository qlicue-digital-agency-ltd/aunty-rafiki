import 'dart:io';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class ChatProvider with ChangeNotifier {
  ///firestore
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  ///message...
  bool _isSendingMessage = false;
  bool get isCreatingGroup => _isSendingMessage;

//

  List<PlatformFile> _paths;
  bool _loadingPath = false;

  List<File> get files => _paths.map((path) => File(path.path)).toList();
  bool get loadingPath => _loadingPath;

  void resetImage() {
    _paths = null;
    notifyListeners();
  }

//send image ....
  Future<void> sendMessage(
      {@required text, @required time, @required user, @required chat}) async {
    List<String> _searchKeywords = [];
    var character = "";
    text.runes.forEach((int rune) {
      character += String.fromCharCode(rune);
      _searchKeywords.add(character);
      print(character);
    });
    _isSendingMessage = true;
    notifyListeners();
    await db.collection('groups/${chat.id}/messages').add({
      'text': text,
      'time': time,
      'user': user,
      'media': [],
      'searchKeywords': _searchKeywords,
    }).then((message) {
      print('------------------------');
      print(message);
      print('++++++++++++++++++++++++');
      return _uploadImage(messageUID: message.id, chat: chat);
    });
  }

  //upload image to server...
  Future<void> _uploadImage({@required messageUID, @required chat}) async {
    List<String> _mediaUrl = [];

    if (files.isNotEmpty) {
      files.forEach((file) async {
        //edit files...
        firebase_storage.UploadTask task = firebase_storage
            .FirebaseStorage.instance
            .ref('uploads/media/' +
                messageUID +
                DateTime.now().toIso8601String() +
                '.png')
            .putFile(file);

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
          //upload image...

          _mediaUrl.add(photoURL);

          _updateMessageMedia(
            url: _mediaUrl,
            messageUID: messageUID,
            chat: chat,
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
      });
    } else {
      _isSendingMessage = false;
      notifyListeners();
    }
  }

  //update message media url......
  _updateMessageMedia(
      {@required String messageUID,
      @required List<String> url,
      @required chat}) {
    if (url.length == files.length) {
      db
          .collection('groups/${chat.id}/messages')
          .doc(messageUID)
          .update({'media': url});

      _paths = null;
      _isSendingMessage = false;
      notifyListeners();
    }
  }

  Future<void> openFileExplorer(
      {@required FileType pickingType,
      @required List<String> allowedExtensions,
      bool multiPick = false}) async {
    _loadingPath = true;
    notifyListeners();

    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: pickingType,
        allowMultiple: multiPick,
        allowedExtensions: allowedExtensions,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    notifyListeners();
  }
}
