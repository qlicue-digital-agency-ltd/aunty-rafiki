import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

typedef NumberCounterOnTap = Function(int);

class NumberCounter extends StatelessWidget {
  final String title;
  final int counter;
  final NumberCounterOnTap onTap;
  final bool isRequired;
  final BuildContext context;

  const NumberCounter(
      {Key key,
      @required this.counter,
      @required this.onTap,
      @required this.title,
      @required this.context,
      this.isRequired = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 240, 240, 1),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: EdgeInsets.only(left: 5),
        height: 60,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 2,
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: title),
                      TextSpan(
                          text: isRequired ? '*' : '',
                          style: TextStyle(color: Colors.red))
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    counter.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
                onPressed: () => _showDialog()),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 1000,
            title: new Text(title),
            initialIntegerValue: counter,
          );
        }).then((value) {
      print(value);
      onTap(value);
    });
  }
}
