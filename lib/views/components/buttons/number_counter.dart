import 'package:flutter/material.dart';

typedef NumberCounterOnTap = Function(int);

class NumberCounter extends StatelessWidget {
  final String title;
  final int counter;
  final NumberCounterOnTap onTap;
  final bool isRequired;
  final BuildContext context;

  NumberCounter(
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
            SizedBox(
              width: 10,
            ),
            Text(
              counter.toString(),
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            IconButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
                onPressed: () {
                  return onTap(-1);
                }),
            IconButton(
                icon: Icon(
                  Icons.arrow_drop_up,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
                onPressed: () {
                  return onTap(1);
                }),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
