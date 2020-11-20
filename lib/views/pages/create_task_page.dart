import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_selector_field.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_switch_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  bool remindMe = true;
  TodoTaskCategory _category = TodoTaskCategory.Clinic;
  String _selectedCategory = "Clinic";
  @override
  Widget build(BuildContext context) {
    Future<void> _showDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Meeting  Personnel'),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    RadioListTile(
                      title: const Text('Clinic'),
                      value: TodoTaskCategory.Clinic,
                      groupValue: _category,
                      onChanged: (TodoTaskCategory value) {
                        setState(() {
                          _category = value;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Suppliments'),
                      value: TodoTaskCategory.Suppliments,
                      groupValue: _category,
                      onChanged: (TodoTaskCategory value) {
                        setState(() {
                          _category = value;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Diet'),
                      value: TodoTaskCategory.Diet,
                      groupValue: _category,
                      onChanged: (TodoTaskCategory value) {
                        setState(() {
                          _category = value;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Others'),
                      value: TodoTaskCategory.Others,
                      groupValue: _category,
                      onChanged: (TodoTaskCategory value) {
                        setState(() {
                          _category = value;
                        });
                      },
                    ),
                  ],
                ),
              );
            }),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  switch (_category) {
                    case TodoTaskCategory.Clinic:
                      setState(() {
                        _selectedCategory = "Clinic";
                      });
                      break;
                    case TodoTaskCategory.Suppliments:
                      setState(() {
                        _selectedCategory = "Suppliments";
                      });
                      break;
                    case TodoTaskCategory.Diet:
                      setState(() {
                        _selectedCategory = "Diet";
                      });
                      break;
                    case TodoTaskCategory.Others:
                      setState(() {
                        _selectedCategory = "Others";
                      });
                      break;
                    default:
                      setState(() {
                        _selectedCategory = "";
                      });
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              "Create New Task",
              style: TextStyle(
                  fontSize: 25,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800]),
            ),

            ///For Spacing
            Spacer(),

            ///Container for TextField

            TextField(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[100])),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey[100])),
                hintText: "Task Name",
                hintStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
            ),

            ///For Spacing
            Spacer(),

            ///Container for timing tray
            Container(
              child: Row(
                children: [
                  ///Container for Icon
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(255, 240, 240, 1)),
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.redAccent,
                    ),
                  ),

                  ///For spacing
                  SizedBox(
                    width: 24,
                  ),

                  ///For Text
                  Text(
                    "Friday 28, November",
                    style: TextStyle(
                        fontSize: 18,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[700]),
                  )
                ],
              ),
            ),

            ///For Spacing
            SizedBox(
              height: 16,
            ),

            ///Container for timing tray 2
            Container(
              child: Row(
                children: [
                  ///Container for Icon
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(255, 250, 240, 1)),
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.alarm,
                      color: Colors.orangeAccent,
                    ),
                  ),

                  ///For spacing
                  SizedBox(
                    width: 24,
                  ),

                  ///For Text
                  Text(
                    "1:00 - 3:00 PM",
                    style: TextStyle(
                        fontSize: 18,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[700]),
                  )
                ],
              ),
            ),

            ///For Spacing
            Spacer(),

            ///Container for Task Category
            IconSelectorField(
              onTap: () {
                _showDialog();
              },
              title: _selectedCategory,
              icon: Icons.web_asset,
            ),

            ///For Spacing
            SizedBox(
              height: 16,
            ),
            IconSwitchField(
              icon: Icons.alarm_on,
              onChanged: (val) {
                setState(() {
                  remindMe = val;
                });
              },
              syncToCalendar: remindMe,
            ),

            Spacer(),

            ///Button for Create Task
            Container(
              width: double.infinity,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                color: Colors.pink,
                child: Text(
                  "CREATE TASK",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
