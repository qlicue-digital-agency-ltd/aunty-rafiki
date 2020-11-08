import 'package:aunty_rafiki/sample/model/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class MessageEditBar extends StatefulWidget {
  MessageEditBar();

  @override
  _MessageEditBarState createState() => _MessageEditBarState();
}

class _MessageEditBarState extends State<MessageEditBar> {
  FirebaseFirestore db;
  TextEditingController _controller;
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  @override
  void initState() {
    db = FirebaseFirestore.instance;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Chat chat = Provider.of<Chat>(context);

    _sendMessage() {
      if (_controller.text.isNotEmpty) {
        db.collection('groups/${chat.id}/messages').add({
          'text': _controller.text,
          'time': Timestamp.fromDate(DateTime.now()),
          'user': FirebaseAuth.instance.currentUser.uid,
          'media': [
  
          ]
        });
        _controller.clear();
      }
    }

    Future<void> loadAssets() async {
      List<Asset> resultList = List<Asset>();
      String error = 'No Error Dectected';

      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 10,
          enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#abcdef",
            actionBarTitle: "Example App",
            allViewTitle: "All Photos",
            useDetailsView: true,
            selectCircleStrokeColor: "#000000",
          ),
        );
      } on Exception catch (e) {
        error = e.toString();
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      setState(() {
        images = resultList;
        _error = error;
      });
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(6.0),
            child: Material(
              elevation: 2,
              color: Colors.white,
              shape: StadiumBorder(),
              child: Row(
                children: [
                  IconButton(
                    icon: new Icon(Icons.face),
                    onPressed: () {
                      // _chatProvider.getSticker();
                    },
                    color: Colors.black26,
                  ),
                  Flexible(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (text) => _sendMessage(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: new Icon(Icons.collections),
                    onPressed: loadAssets,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
          ),
        ),
        Material(
          elevation: 2,
          shape: CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: Theme.of(context).primaryColor,
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 6),
      ],
    );
  }
}
