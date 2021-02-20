import 'dart:io';
import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ChatProvider with ChangeNotifier {
  ///firestore
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  ///message...
  bool _isSendingMessage = false;
  String _mediaType = "NON";
  Map<String, Message> _selectedMessages = {};

  ScrollController _scrollController = new ScrollController();

  Message _messageToReply;

  List<PlatformFile> _paths = [];
  List<File> _compressedFiles = [];
  bool _loadingPath = false;

  ///setter..
  setMessage({@required String uid, @required Message message}) {
    if (_selectedMessages.containsKey(uid)) {
      _selectedMessages.remove(uid);
      print('removed');
    } else {
      _selectedMessages[uid] = message;
      print('added');
    }
    print(_selectedMessages.length);
    notifyListeners();
  }

  set setMessageToReply(Message message) {
    _messageToReply = message;
    notifyListeners();
  }

  ///scroll to bottom of chats
  void scrollToBootomOfChats() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    notifyListeners();
  }

  ///getters..
  List<File> get files => _paths.map((path) => File(path.path)).toList();
  List<File> get compressedFiles => _compressedFiles;
  bool get loadingPath => _loadingPath;
  Map<String, Message> get selectedMessages => _selectedMessages;
  bool get isCreatingGroup => _isSendingMessage;
  Message get messageToReply => _messageToReply;
  ScrollController get scrollController => _scrollController;

  void clearSelectedMedia() {
    _mediaType = "NON";
    _paths = [];
    _compressedFiles = [];
    notifyListeners();
  }

//send image ....
  Future<void> sendMessage(
      {@required text,
      @required time,
      @required user,
      @required Chat chat,
      @required Message repliedMessage}) async {
    List<String> _searchKeywords = [];
    var character = "";
    text.runes.forEach((int rune) {
      character += String.fromCharCode(rune);
      _searchKeywords.add(character.toLowerCase());
      print(character);
    });
    _isSendingMessage = true;
    notifyListeners();
    await db.collection('groups/${chat.id}/messages').add({
      'text': text,
      'time': time,
      'user': user,
      'media': [],
      'repliedUID': repliedMessage != null ? repliedMessage.id : null,
      'showDeletedMessage': true,
      'mediaType': _mediaType.replaceAll('FileType.', ''),
      'searchKeywords': _searchKeywords,
      'members': chat.members
    }).then((message) {
      if (files.isNotEmpty) {
        _compressListFiles(messageUID: message.id, chat: chat);
      } else {
        _isSendingMessage = false;
        _mediaType = "NON";
        setMessageToReply = null;
        notifyListeners();
      }
    });
  }

  //upload image to server...
  Future<void> _uploadImage({@required messageUID, @required chat}) async {
    List<String> _mediaUrl = [];
    if (_compressedFiles.isNotEmpty) {
      _compressedFiles.forEach((file) async {
        //edit files...
        firebase_storage.UploadTask task = firebase_storage
            .FirebaseStorage.instance
            .ref('uploads/media/' +
                messageUID +
                DateTime.now().toIso8601String())
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

      clearSelectedMedia();
      _isSendingMessage = false;

      notifyListeners();
    }
  }

  Future<void> openFileExplorer(
      {@required FileType pickingType,
      @required List<String> allowedExtensions,
      bool multiPick = false}) async {
    _mediaType = pickingType.toString();
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

  ///multiple files compression helper....
  _compressListFiles({@required messageUID, @required chat}) async {
    final dir = await path_provider.getTemporaryDirectory();
    int i = 0;
    if (_mediaType.replaceAll('FileType.', '') == "image") {
      files.forEach((file) async {
        var targetPath =
            dir.absolute.path + "/temp" + DateTime.now().toString() + "$i.jpg";
        await compressAndGetFile(file, targetPath);
        i++;
        if (i == files.length) {
          _compressedFiles.forEach((element) {});

          _uploadImage(messageUID: messageUID, chat: chat);
        }
      });
    } else {
      _compressedFiles = files;
      _uploadImage(messageUID: messageUID, chat: chat);
    }
  }

  ///Compress a single file..
  Future<File> compressAndGetFile(File file, String targetPath) async {
    int bytes = await file.length();
    print("bytes:=> $bytes");
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 0,
      rotate: 0,
    );
    _compressedFiles.add(result);
    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  ///update chat message..
  updateChatMessage(
      {@required String key,
      @required dynamic data,
      @required messageUID,
      @required chat}) async {
    await db.collection('groups/${chat.id}/messages').doc(messageUID).update({
      key: data,
    });
  }

  ///delete chat message..
  Future<void> deleteChatMessage(
      {@required String choice,
      messageUID,
      @required Chat chat,
      @required userUID}) async {
    switch (choice) {
      case 'me_only':

        ///delete for me only messages..
        await _deleteChatMessageFirebase(
          chat: chat,
          userUID: userUID,
        );
        break;
      case 'both_of_us':

        ///delete messages for everyone..

        await _deleteChatMessageFirebase(
          chat: chat,
          userUID: null,
        );
        break;
      default:

        ///delete messages..
        await updateChatMessage(
            chat: chat,
            messageUID: messageUID,
            key: 'showDeletedMessage',
            data: false);
    }
  }

//firebase delete massage...
  _deleteChatMessageFirebase({@required Chat chat, @required userUID}) async {
    int i = 0;
    if (userUID != null) {
      _selectedMessages.forEach(((uid, message) async {
        await db
            .collection('groups/${chat.id}/messages')
            .doc(message.id)
            .update({
          'members': FieldValue.arrayRemove([userUID])
        });
        i++;
        if (i == _selectedMessages.length) clearSelectedChats();
      }));
    } else {
      _selectedMessages.forEach(((uid, message) async {
        await db
            .collection('groups/${chat.id}/messages')
            .doc(message.id)
            .update({'members': []});
        i++;
        if (i == _selectedMessages.length) clearSelectedChats();
      }));
    }
  }

  clearSelectedChats() {
    _selectedMessages.clear();
    notifyListeners();
  }


  ///
}
