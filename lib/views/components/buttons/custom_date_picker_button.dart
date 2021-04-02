import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool _isRequired;
  final String _title;
  final Function(DateTime) _onChange;
  final DateTime _selectedDate;
  final int _minimumYear;
  final int _maximumYear;

  const CustomDatePickerButton(
      {Key key,
      @required bool isRequired,
      @required String title,
      @required this.scaffoldKey,
      @required DateTime selectedDate,
      @required int minimumYear,
      @required int maximumYear,
      @required Function(DateTime) onChange})
      : _selectedDate = selectedDate,
        _title = title,
        _isRequired = isRequired,
        _minimumYear = minimumYear,
        _maximumYear = maximumYear,
        _onChange = onChange,
        super(key: key);
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
                text: TextSpan(children: [
                  TextSpan(text: _title),
                  TextSpan(
                      text: _isRequired ? '*' : '',
                      style: TextStyle(color: Colors.red))
                ], style: TextStyle(color: Colors.black45)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(_selectedDate == null
                  ? '---Select Date---'
                  : DateFormat('dd-MM-yyyy').format(_selectedDate)),
            ),
            IconButton(
              tooltip: 'Select a Date',
              icon: Icon(
                Icons.calendar_today,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () => selectDateIOS(scaffoldKey.currentContext),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  Future<void> selectDateIOS(
    BuildContext context,
  ) async {
    DateTime picked;

    /// GlobalKey<ScaffoldState> scaffoldKey
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext builder) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        
                          onPressed: () {
                            _onChange(null);
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Container(
                            height: 10,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'DONE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          ),
                          onPressed: () {
                            if (picked != null && picked != _selectedDate) {
                              _onChange(picked);
                            } else {}

                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height:
                          MediaQuery.of(context).copyWith().size.height / 3.5,
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (DateTime newdate) {
                          picked = newdate;
                        },
                        minimumYear: _minimumYear,
                        maximumYear: _maximumYear,
                        mode: CupertinoDatePickerMode.date,
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
