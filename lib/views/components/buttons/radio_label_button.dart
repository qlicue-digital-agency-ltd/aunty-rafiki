import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkedLabelRadio extends StatelessWidget {
  const LinkedLabelRadio({
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final int groupValue;
  final int value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Radio<int>(
              groupValue: groupValue,
              value: value,
              onChanged: (int newValue) {
                onChanged(newValue);
              }),
          RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(color: Colors.black, fontSize: 18),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onChanged(value);
                },
            ),
          ),
        ],
      ),
    );
  }
}
