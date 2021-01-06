import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomDatePickerButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isRequired;
  final String title;

  const CustomDatePickerButton(
      {Key key,
      this.isRequired = false,
      this.title = 'Expiry Date ',
      @required this.scaffoldKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
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
                text: TextSpan(children: [
                  TextSpan(text: title),
                  TextSpan(
                      text: isRequired ? '*' : '',
                      style: TextStyle(color: Colors.red))
                ], style: TextStyle(color: Colors.black45)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(_utilityProvider.selectedDate == null
                  ? '---Select Date---'
                  : DateFormat('dd-MM-yyyy')
                      .format(_utilityProvider.selectedDate)),
            ),
            IconButton(
              tooltip: 'Select a Date',
              icon: Icon(
                Icons.calendar_today,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () =>
                  _utilityProvider.selectDateIOS(scaffoldKey.currentContext),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
