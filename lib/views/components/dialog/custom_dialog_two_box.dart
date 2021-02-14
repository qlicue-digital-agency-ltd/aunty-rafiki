import 'dart:ui';
import 'package:aunty_rafiki/constants/app/constants.dart';
import 'package:aunty_rafiki/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogTwoBox extends StatefulWidget {
  final Image img;
  final List<Message> listMessage;
  final Function _onClose, _onDeleteOne, _onDeleteTwo;

  const CustomDialogTwoBox({
    Key key,
    this.img,
    @required Function onClose,
    @required Function onDeleteOne,
    @required Function onDeleteTwo,
    @required this.listMessage,
  })  : _onClose = onClose,
        _onDeleteOne = onDeleteOne,
        _onDeleteTwo = onDeleteTwo,
        super(key: key);

  @override
  _CustomDialogTwoBoxState createState() => _CustomDialogTwoBoxState();
}

class _CustomDialogTwoBoxState extends State<CustomDialogTwoBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Delete message?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                  onPressed: widget._onDeleteOne,
                  child: Text(
                    'DELETE FOR ME',
                    style: TextStyle(fontSize: 16, color: Colors.pink),
                  )),
              SizedBox(
                height: 5,
              ),
              FlatButton(
                  onPressed: widget._onClose,
                  child: Text(
                    'CANCEL',
                    style: TextStyle(fontSize: 16, color: Colors.pink),
                  )),
              SizedBox(
                height: 5,
              ),
              widget.listMessage.length > 1
                  ? Container()
                  : widget.listMessage.first.sender ==
                          FirebaseAuth.instance.currentUser.uid
                      ? FlatButton(
                          textColor: Colors.pink,
                          onPressed: widget._onDeleteTwo,
                          child: Text(
                            'DELETE FOR EVERYONE',
                            style: TextStyle(fontSize: 16, color: Colors.pink),
                          ))
                      : Container(),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/icons/aunty_rafiki.png")),
          ),
        ),
      ],
    );
  }
}
