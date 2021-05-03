import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color color;
  const Loading({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Platform.isAndroid
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(color),
              )
            : CupertinoActivityIndicator(),
      ),
    );
  }
}
