import 'dart:io';

import 'package:aunty_rafiki/constants/colors/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Platform.isAndroid
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : CupertinoActivityIndicator(
              
            ),
      ),
    );
  }
}
