import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class ChatProvider with ChangeNotifier {
  //////
  bool _loadingPath = false;
  bool _multiPick = false;
  String _directoryPath;
  List<File> _paths;
  /////
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  File _pickedImage, file;
  bool _isSendingMessage = false;
  //getters....
  File get pickedImage => _pickedImage;
  bool get isCreatingGroup => _isSendingMessage;

  //file pickers
  Future<void> chooseAnImage() async {
    file = await ImagePicker.pickImage(source: ImageSource.gallery);

    _pickedImage = file;

    notifyListeners();
  }

  void resetImage() {
    _pickedImage = null;
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
    if (_pickedImage != null) {
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref('uploads/media/' +
              messageUID +
              DateTime.now().toIso8601String() +
              '.png')
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
        //upload image...

        _updateMessageMedia(
          url: photoURL,
          messageUID: messageUID,
          chat: chat,
        );
        print('Upload complete.' + photoURL);
        _pickedImage = null;
        _isSendingMessage = false;
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
      _isSendingMessage = false;
      notifyListeners();
    }
  }

  //update message media url......
  _updateMessageMedia(
      {@required String messageUID, @required String url, @required chat}) {
    db.collection('groups/${chat.id}/messages').doc(messageUID).update({
      'media': [url]
    });
  }

  // //pick files..
  // void _openFileExplorer() async {
  //   _loadingPath = true;
  //   notifyListeners();
  //   try {
  //     _directoryPath = null;
  //     _paths = (await FilePicker.platform.pickFiles(
  //       type: _pickingType,
  //       allowMultiple: _multiPick,
  //       allowedExtensions: (_extension?.isNotEmpty ?? false)
  //           ? _extension?.replaceAll(' ', '')?.split(',')
  //           : null,
  //     ))
  //         ?.files;
  //   } on PlatformException catch (e) {
  //     print("Unsupported operation" + e.toString());
  //   } catch (ex) {
  //     print(ex);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _loadingPath = false;
  //     _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
  //   });
  // }



}
