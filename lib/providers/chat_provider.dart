import 'dart:io';
import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/models/message.dart';
import 'package:aunty_rafiki/models/private_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String _mediaType = "NON";

  Map<String, Message> _selectedMessages = {};
  Map<int, String> _selectedUsers = {};
  Map<String, PrivateMessage> _selectedPrivateMessages = {};
  int _limit = 20;
  int _limitIncrement = 20;

  ScrollController _scrollController = new ScrollController();

  Message _messageToReply;
  PrivateMessage _privateMessageToReply;

  List<PlatformFile> _paths = [];

  bool _loadingPath = false;

  ///private groups ...
  String _groupChatId;
  String _peerId;

  ///setter..
  ///set
  set setgroupChatId(String groupChatId) {
    _groupChatId = groupChatId;
    notifyListeners();
  }

  set setPeerId(String peerId) {
    _peerId = peerId;
    notifyListeners();
  }

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

  setPrivateMessage({@required String uid, @required PrivateMessage message}) {
    if (_selectedPrivateMessages.containsKey(uid)) {
      _selectedPrivateMessages.remove(uid);
      print('removed');
    } else {
      _selectedPrivateMessages[uid] = message;
      print('added');
    }

    notifyListeners();
  }

  set setMessageToReply(Message message) {
    _messageToReply = message;
    notifyListeners();
  }

  set setPrivateMessageToReply(PrivateMessage message) {
    _privateMessageToReply = message;
    notifyListeners();
  }

  ///scroll to bottom of chats
  void scrollToBootomOfChats() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
    notifyListeners();
  }

  ///getters..
  ///

  ///private groups ...
  String get groupChatId => _groupChatId;
  String get peerId => _peerId;

  List<File> get files => _paths.map((path) => File(path.path)).toList();

  bool get loadingPath => _loadingPath;

  Map<String, Message> get selectedMessages => _selectedMessages;
  Map<int, String> get selectedUsers => _selectedUsers;

  Map<String, PrivateMessage> get selectedPrivateMessages =>
      _selectedPrivateMessages;
  bool get isCreatingGroup => _isSendingMessage;
  Message get messageToReply => _messageToReply;
  PrivateMessage get privateMessageToReply => _privateMessageToReply;
  int get limit => _limit;

  ScrollController get scrollController => _scrollController;

  scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _limit += _limitIncrement;
      notifyListeners();
    }
  }

  void clearSelectedMedia() {
    _mediaType = "NON";
    _paths = [];
    notifyListeners();
  }

//send image ....
  Future<void> sendMessage(
      {@required text,
      @required time,
      @required user,
      @required senderName,
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
      'senderName': senderName,
      'media': [],
      'repliedUID': repliedMessage != null ? repliedMessage.id : null,
      'showDeletedMessage': true,
      'mediaType': _mediaType.replaceAll('FileType.', ''),
      'searchKeywords': _searchKeywords,
      'members': chat.members
    }).then((message) {
      if (files.isNotEmpty) {
        _uploadImage(messageUID: message.id, chat: chat);
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
    if (files.isNotEmpty) {
      files.forEach((file) async {
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

  //upload image to server...
  Future<void> _uploadPrivateImage(
      {@required groupChatID,
      @required DocumentReference documentReference}) async {
    List<String> _mediaUrl = [];
    if (files.isNotEmpty) {
      files.forEach((file) async {
        //edit files...
        firebase_storage.UploadTask task = firebase_storage
            .FirebaseStorage.instance
            .ref('uploads/media/' +
                groupChatID +
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

          _updatePrivateMessageMedia(
            url: _mediaUrl,
            documentReference: documentReference,
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

  //update message media url......
  _updatePrivateMessageMedia(
      {@required List<String> url,
      @required DocumentReference documentReference}) {
    if (url.length == files.length) {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(
          documentReference,
          {'media': url},
        );
      });

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

  ///delete chat message..
  Future<void> deletePrivateChatMessage({
    @required String choice,
    messageUID,
    @required userUID,
  }) async {
    switch (choice) {
      case 'me_only':

        ///delete for me only messages..
        await _deletePrivateChatMessageFirebase(
          userUID: userUID,
        );
        break;
      case 'both_of_us':

        ///delete messages for everyone..
        await _deletePrivateChatMessageFirebase(
          userUID: null,
        );
        break;
      default:
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

  _deletePrivateChatMessageFirebase({@required userUID}) async {
    int i = 0;
    if (userUID != null) {
      _selectedPrivateMessages.forEach(((uid, message) async {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.update(
            message.reference,
            {
              'idFrom': null,
            },
          );
        });
        i++;
        if (i == _selectedPrivateMessages.length) clearSelectedChats();
      }));
    } else {
      _selectedPrivateMessages.forEach(((uid, message) async {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.update(
            message.reference,
            {
              'idFrom': null,
              'idTo': null,
            },
          );
        });
        i++;
        if (i == _selectedPrivateMessages.length) clearSelectedChats();
      }));
    }
  }

  clearSelectedChats() {
    _selectedMessages.clear();
    _selectedPrivateMessages.clear();
    notifyListeners();
  }

  Future<void> onSendPrivateMessage(
      {@required String content,
      @required String groupChatId,
      @required String peerId,
      @required String senderId,
      @required dynamic time}) async {
    ///add chat to user
    addChatToUser(senderId, peerId);

    ///sending the sms
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          'idFrom': senderId,
          'idTo': peerId,
          'time': time,
          'content': content,
          'media': [],
          'repliedUID': null,
          'mediaType': _mediaType.replaceAll('FileType.', ''),
          'showDeletedMessage': true
        },
      );
    }).then((value) {
      if (files.isNotEmpty) {
        _uploadPrivateImage(
            groupChatID: groupChatId, documentReference: documentReference);
      } else {
        _isSendingMessage = false;
        _mediaType = "NON";
        setMessageToReply = null;
        notifyListeners();
      }
    });
  }

  //user private sms list
  addChatToUser(String senderId, String peerId) async {
    //adding chat to sender
    db.collection('users').doc(senderId).update({
      'chats': FieldValue.arrayUnion([peerId]),
    });

    //adding chat to sender
    db.collection('users').doc(peerId).update({
      'chats': FieldValue.arrayUnion([senderId]),
    });
  }

  deleteUserChat() async {
    _selectedUsers.forEach(((index, peerId) async {
      //remove user reference
      await db
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'chats': FieldValue.arrayRemove([peerId])
      });
      _selectedUsers.remove(index);
    }));

    notifyListeners();
  }

  selectContact({@required int index, @required String uid}) {
    print(index);
    print(uid);
    if (_selectedUsers.containsKey(index)) {
      _selectedUsers.remove(index);
    } else {
      _selectedUsers[index] = uid;
    }
    print(_selectedUsers.length);
    notifyListeners();
  }
}
