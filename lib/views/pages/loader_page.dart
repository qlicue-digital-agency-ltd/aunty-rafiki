import 'dart:io';

import 'package:aunty_rafiki/views/backgrounds/loader_back_ground.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoaderBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('AUNT RAFIKI FROM QLICUE'),
              Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Image.asset(
                    'assets/icons/aunty_rafiki.png',
                    height: 25.0,
                    fit: BoxFit.scaleDown,
                  ))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Platform.isAndroid
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.pink),
                        )
                      : CupertinoActivityIndicator())
            ],
          ),
        ],
      ),
    );
  }
}
