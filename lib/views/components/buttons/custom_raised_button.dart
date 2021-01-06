import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String _title;
  final Function _onPressed;

  const CustomRaisedButton(
      {Key key, @required String title, @required Function onPressed})
      : _title = title,
        _onPressed = onPressed,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.pink[400],
              child: Text(
                _title.toUpperCase(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
              onPressed: _onPressed,
            ),
          ),
        ),
      ],
    );
  }
}
