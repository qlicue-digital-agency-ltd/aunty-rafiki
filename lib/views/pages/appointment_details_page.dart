import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/models/appointment.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_date_field.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_selector_field.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_switch_field.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_text_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsPage extends StatefulWidget {
  final Appointment appointment;

  AppointmentDetailsPage({Key key, @required this.appointment})
      : super(key: key);

  @override
  _AppointmentDetailsPageState createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  FocusNode _notesFocusNode = FocusNode();

  TextEditingController _descriptionEditingController = TextEditingController();
  TextEditingController _notesEditingController = TextEditingController();

  ///edited..
  bool _editAppointmetName = false;
  bool _editAppointmentDate = false;
  bool _editAppointmentTime = false;
  bool _editAppointmentProfession = false;
  bool _editAppointmentNotes = false;

  ///
  String date = 'Date';
  String time = 'Time';
  bool _syncToCalendar = false;
  String valueDate = '';
  String valueToValidate3 = '';
  String valueSaved3 = '';
  String valueTime = '';
  String valueToValidate4 = '';
  String _selectedProfession = "Doctor";

  TextEditingController _dateEditingController;
  TextEditingController _timeEditingController;
  AvailableProfessions _character = AvailableProfessions.doctor;

  @override
  void initState() {
    super.initState();

    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _timeEditingController = TextEditingController(text: '$lsHour:$lsMinute');
    _getValue();
  }

  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _dateEditingController.text = '22-11-2020';
        _timeEditingController.text = '17:01';
      });
    });
  }

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
                      title: const Text('Doctor'),
                      value: AvailableProfessions.doctor,
                      groupValue: _character,
                      onChanged: (AvailableProfessions value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Midwife'),
                      value: AvailableProfessions.midwife,
                      groupValue: _character,
                      onChanged: (AvailableProfessions value) {
                        setState(() {
                          _character = value;
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
                  switch (_character) {
                    case AvailableProfessions.doctor:
                      setState(() {
                        _selectedProfession = "Doctor";
                      });
                      break;
                    case AvailableProfessions.midwife:
                      setState(() {
                        _selectedProfession = "Midwife";
                      });
                      break;
                    default:
                      setState(() {
                        _selectedProfession = "";
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
        title: Text('Appointment Details'),
        actions: [
          IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  IconTextField(
                    content: widget.appointment.name,
                    icon: Icons.assignment,
                    textEditingController: _descriptionEditingController,
                    title: 'Appointment Name',
                    validator: (val) {
                      if (val.isEmpty)
                        return 'Enter the appointment name';
                      else
                        return null;
                    },
                    isEditing: _editAppointmetName,
                    onEdit: () {
                      setState(() {
                        _editAppointmetName = !_editAppointmetName;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  IconDateField(
                    date: widget.appointment.date,
                    isEditing: _editAppointmentDate,
                    onEdit: () {
                      setState(() {
                        _editAppointmentDate = !_editAppointmentDate;
                      });
                    },
                    onChage: (val) {},
                    onSaved: (val) {},
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
                    icon: Icons.access_time,
                    title: 'Time',
                    dateMask: 'dd/MM/yyyy',
                    type: DateTimePickerType.time,
                    date: widget.appointment.time,
                    isEditing: _editAppointmentTime,
                    onEdit: () {
                      setState(() {
                        _editAppointmentTime = !_editAppointmentTime;
                      });
                    },
                  ),
                  IconSelectorField(
                    onTap: () {
                      _showDialog();
                    },
                    title: _selectedProfession,
                    icon: Icons.assignment_ind,
                    isEditing: _editAppointmentProfession,
                    onEdit: () {
                      _editAppointmentProfession = !_editAppointmentProfession;
                    },
                    profession: widget.appointment.profession,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  IconSwitchField(
                    icon: Icons.alarm_on,
                    onChanged: (val) {
                      setState(() {
                        _syncToCalendar = val;
                      });
                    },
                    syncToCalendar: _syncToCalendar,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Notes:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  _editAppointmentNotes
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueGrey[100]),
                              color: Colors.transparent),
                          child: TextFormField(
                            maxLines: 4,
                            focusNode: _notesFocusNode,
                            controller: _notesEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ))
                      : Row(
                          children: [
                            Text(
                              widget.appointment.additionalNotes,
                              maxLines: 10,
                            ),
                          ],
                        ),
                  SizedBox(height: 30),
                ],
              ),
            )),
          )
        ]),
      ),
    );
  }
}
