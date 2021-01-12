import 'dart:ui';
import 'package:aunty_rafiki/constants/app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String _title, _descriptions, _text, _textClose;
  final Image img;
  final Function _onClose;
  final Function _onPressed;

  const CustomDialogBox(
      {Key key,
      String title,
      String descriptions,
      String text,
      String textClose,
      this.img,
      Function onClose,
      Function onPressed})
      : _title = title,
        _textClose = textClose,
        _descriptions = descriptions,
        _text = text,
        _onClose = onClose,
        _onPressed = onPressed,
        super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
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
              Text(
                widget._title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget._descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    FlatButton(
                        onPressed: widget._onClose,
                        child: Text(
                          widget._textClose,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                    Spacer(),
                    FlatButton(
                        textColor: Colors.pink,
                        onPressed: widget._onPressed,
                        child: Text(
                          widget._text,
                          style: TextStyle(fontSize: 18, color: Colors.pink),
                        )),
                  ],
                ),
              ),
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
