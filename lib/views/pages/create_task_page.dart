import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/providers/task_provider.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_date_field.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_selector_field.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_switch_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  @override
  void initState() {
    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _timeEditingController = TextEditingController(text: '$lsHour:$lsMinute');
    _getValue();
    super.initState();
  }

  bool remindMe = true;
  TextEditingController _dateEditingController;
  TextEditingController _timeEditingController;
  TextEditingController _nameEditingController = TextEditingController();
  TodoTaskCategory _category = TodoTaskCategory.Clinic;
  FocusNode _nameFocusNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedCategory = "Clinic";
  String date = 'Date';
  String time = 'Time';
  String valueDate = '';
  String valueToValidate3 = '';
  String valueSaved3 = '';
  String valueTime = '';
  String valueToValidate4 = '';

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _dateEditingController.text = '22-11-2020';
        _timeEditingController.text = DateTime.now().hour.toString() +
            ":" +
            DateTime.now().minute.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _taskProvider = Provider.of<TaskProvider>(context);

    _dateEditingController =
        TextEditingController(text: DateTime.now().toString());
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
        child: Form(
          key: _formKey,
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
                controller: _nameEditingController,
                focusNode: _nameFocusNode,
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
              IconDateField(
                onChage: (val) {
                  print("------------------------------------");
                  print(val);
                  print("------------------------------------");
                },
                onSaved: (val) {
                  print("------------------+++------------------");
                  print(val);
                  print("------------------+++-----------------");
                },
                onValidate: (val) {
                  setState(() => valueToValidate3 = val);
                  return null;
                },
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                textEditingController: _dateEditingController,
                icon: Icons.calendar_today,
                title: 'Date',
                dateMask: "EEEE, MMMM d, y",
                type: DateTimePickerType.date,
                date: null,
                isEditing: false,
                onEdit: null,
              ),
              SizedBox(
                height: 16,
              ),

              IconDateField(
                onChage: (val) {
                  print(val);
                  print("0000");
                },
                onSaved: (val) {
                  print(val);
                },
                onValidate: (val) {
                  setState(() => valueToValidate4 = val);
                  return null;
                },
                textEditingController: _timeEditingController,
                icon: Icons.alarm,
                title: 'Time',
                dateMask: 'dd/MM/yyyy',
                type: DateTimePickerType.time,
                date: null,
                isEditing: false,
                onEdit: null,
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
                isEditing: false,
                onEdit: null,
                profession: null,
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
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print('save the data');
                      _taskProvider
                          .createTask(
                              name: _nameEditingController.text,
                              date: _dateEditingController.text,
                              time: _timeEditingController.text,
                              category: _selectedCategory,
                              reminder: remindMe,
                              stage: 'incoming')
                          .then((value) {
                        if (!value) {
                          print('bosssssssssss');
                          Navigator.pop(context);
                        } else {
                          print('Error while submitting data');
                        }
                      });
                    } else {}
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
