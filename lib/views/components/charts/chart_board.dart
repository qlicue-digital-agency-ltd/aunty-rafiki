import 'package:flutter/material.dart';

class Chartboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
      constraints: const BoxConstraints(maxHeight: 170),
      decoration: BoxDecoration(
        color: Colors.pink.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
