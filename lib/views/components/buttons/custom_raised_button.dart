import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String _title;
  final Function _onPressed;
  final bool _isPressed;

  const CustomRaisedButton(
      {Key key,
      @required String title,
      @required Function onPressed,
      bool isPressed})
      : _title = title,
        _onPressed = onPressed,
        _isPressed = isPressed,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 16),
             
            ),

            
            child: _isPressed
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    _title.toUpperCase(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
            onPressed: _onPressed,
          ),
        ),
      ],
    );
  }
}
