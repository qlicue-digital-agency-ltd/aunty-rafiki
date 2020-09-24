import 'package:aunty_rafiki/models/chat.dart';
import 'package:aunty_rafiki/models/message.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  bool _isShowSticker = false;
  List<Chat> _chatList = [];
  Chat _selectedChat;

  ChatProvider() {
    loadChats();
  }
//setter
  void getSticker() {
    // Hide keyboard when sticker appear
    // focusNode.unfocus();

    _isShowSticker = !_isShowSticker;
    notifyListeners();
  }

  set selectChat(Chat chat) {
    _selectedChat = chat;
    notifyListeners();
  }

  //getters
  bool get isShowSticker => _isShowSticker;

  List<Chat> get chatList => List<Chat>.from(_chatList);
  Chat get selectedChat => _selectedChat;

  void loadChats() {
    _chatList = <Chat>[
      Chat(
          avatar: 'assets/images/a.jpg',
          name: 'Matias',
          date: DateTime.now(),
          uuid: 'chat1',
          unreadMessageCounter: 0,
          chartType: 'private',
          messages: [
            Message(
              text: 'Hello world today',
              date: DateTime.now(),
              chatUuid: 'YYUU90989',
              sentByMe: false,
              sender: 'Henry Victor',
              phoneNumber: '+29982222',
              userName: '~P-L',
              image: 'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
              type: 'plain-text',
            ),
            Message(
              text: 'Hello world today',
              date: DateTime.now(),
              chatUuid: 'YYUU90989',
              sentByMe: false,
              phoneNumber: '+255715785672',
              userName: "~P-L😂",
              image: 'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
              type: 'plain-text',
            ),
          ]),
      Chat(
          avatar: 'assets/images/b.jpg',
          name: 'Goup Soccer',
          date: DateTime.now(),
          uuid: 'chat2',
          unreadMessageCounter: 2,
          chartType: 'group',
          messages: [
            Message(
                text: 'Hello world today',
                date: DateTime.now(),
                chatUuid: 'YYUU90989',
                sentByMe: false,
                sender: 'Mary Paul',
                phoneNumber: '+29982222',
                userName: '~K-L',
                image:
                    'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
                type: 'image'),
            Message(
              text: 'Hello world today',
              date: DateTime.now(),
              chatUuid: 'YYUU90989',
              sentByMe: true,
              sender: 'James',
              image: 'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
              phoneNumber: '+29982222',
              userName: '~R-D',
              type: 'plain-text',
            ),
          ]),
      Chat(
          avatar: 'assets/images/c.jpeg',
          name: 'Marry',
          date: DateTime.now(),
          uuid: 'chat3',
          unreadMessageCounter: 10,
          chartType: 'private',
          messages: [
            Message(
                text: 'Hello world today',
                date: DateTime.now(),
                chatUuid: 'YYUU90989',
                sentByMe: false,
                sender: 'Mary Paul',
                phoneNumber: '+29982222',
                userName: '~K-L',
                image:
                    'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
                type: 'image'),
            Message(
              text: 'Hello world today',
              date: DateTime.now(),
              chatUuid: 'YYUU90989',
              sentByMe: true,
              sender: 'James',
              image: 'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
              phoneNumber: '+29982222',
              userName: '~R-D',
              type: 'plain-text',
            ),
          ]),
      Chat(
          avatar: 'assets/images/d.jpeg',
          name: 'Family',
          date: DateTime.now(),
          uuid: 'chat4',
          unreadMessageCounter: 0,
          chartType: 'group',
          messages: [
            Message(
                text: 'Hello world today',
                date: DateTime.now(),
                chatUuid: 'YYUU90989',
                sentByMe: false,
                sender: 'Mary Paul',
                phoneNumber: '+29982222',
                userName: '~K-L',
                image:
                    'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
                type: 'image'),
            Message(
              text: 'Hello world today',
              date: DateTime.now(),
              chatUuid: 'YYUU90989',
              sentByMe: true,
              sender: 'James',
              image: 'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
              phoneNumber: '+29982222',
              userName: '~R-D',
              type: 'plain-text',
            ),
          ]),
      Chat(
          avatar: 'assets/images/a.jpg',
          name: 'Peter',
          date: DateTime.now(),
          uuid: 'chat5',
          chartType: 'private',
          unreadMessageCounter: 3,
          messages: [
            Message(
                text: 'Hello world today',
                date: DateTime.now(),
                chatUuid: 'YYUU90989',
                sentByMe: false,
                sender: 'Mary Paul',
                phoneNumber: '+29982222',
                userName: '~K-L',
                image:
                    'assets/baby/getty_rm_photo_of_sperm_fertilizing_egg.jpg',
                type: 'image'),
          ])
    ];
    notifyListeners();
  }

  sendMessage({@required String text, @required String type}) {
    final _message = Message(
        text: text,
        date: DateTime.now(),
        chatUuid: _selectedChat.uuid,
        sentByMe: true,
        type: type,
        phoneNumber: '_255715785672',
        userName: 'Robbyn');

    _chatList
        .firstWhere((_chat) => _chat.uuid == _selectedChat.uuid)
        .messages
        .add(_message);
    notifyListeners();
  }
}
