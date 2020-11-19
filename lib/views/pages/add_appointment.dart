import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAppointmentPage extends StatefulWidget {
  @override
  _AddAppointmentPageState createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  FocusNode _descriptionFocusNode = FocusNode();

  FocusNode _notesFocusNode = FocusNode();

  String date = 'Date';
  String time = 'Time';
  bool _syncToCalendar = false;
  String valueDate = '';
  String valueToValidate3 = '';
  String valueSaved3 = '';
  String valueTime = '';
  String valueToValidate4 = '';
  String valueSaved4 = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _descriptionEditingController = TextEditingController();

  TextEditingController _notesEditingController = TextEditingController();
  TextEditingController _professionEditingController = TextEditingController();
  TextEditingController _dateEditingController;
  TextEditingController timeEditingController;
  AvailableProfessions _character = AvailableProfessions.doctor;

  @override
  void initState() {
    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    timeEditingController = TextEditingController(text: '$lsHour:$lsMinute');
    _getValue();
    super.initState();
  }

  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _dateEditingController.text = '22-11-2020';
        timeEditingController.text = '17:01';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    _dateEditingController = TextEditingController(
        text: _appointmentProvider.selectedCalendarDay.toString());
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
                        _professionEditingController.text = "Doctor";
                      });
                      break;
                    case AvailableProfessions.midwife:
                      setState(() {
                        _professionEditingController.text = "Midwife";
                      });
                      break;
                    default:
                      setState(() {
                        _professionEditingController.text = "";
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
      appBar: AppBar(title: Text('Add Appointment')),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Material(
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    validator: (val) {
                      if (val.isEmpty)
                        return 'Enter the appointment name';
                      else
                        return null;
                    },
                    focusNode: _descriptionFocusNode,
                    controller: _descriptionEditingController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.assignment), labelText: 'Name'),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Material(
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    validator: (val) {
                      if (val.isEmpty)
                        return 'Select the profession you are visiting';
                      else
                        return null;
                    },
                    onTap: () {
                      print('object');
                      _showDialog();
                    },

                    // focusNode: _professionFocusNode,
                    controller: _professionEditingController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.assignment_ind),
                        labelText: 'Profession'),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Material(
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'dd/MM/yyyy',
                    controller: _dateEditingController,
                    //initialValue: _initialValue,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    onChanged: (val) => setState(() => valueDate = val),
                    validator: (val) {
                      setState(() => valueToValidate3 = val);
                      return null;
                    },
                    onSaved: (val) => setState(() => valueSaved3 = val),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Material(
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DateTimePicker(
                    type: DateTimePickerType.time,
                    controller: timeEditingController,
                    //initialValue: _initialValue,
                    icon: Icon(Icons.access_time),
                    timeLabelText: "Time",
                    //use24HourFormat: false,
                    onChanged: (val) => setState(() => valueTime = val),
                    validator: (val) {
                      setState(() => valueToValidate4 = val);
                      return null;
                    },
                    onSaved: (val) => setState(() => valueSaved4 = val),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Material(
                  elevation: 2,
                  color: Colors.white,
                  child: ListTile(
                    title: Text('Sync to Calendar'),
                    trailing: Switch(
                        value: _syncToCalendar,
                        onChanged: (val) {
                          print(val);
                          setState(() {
                            _syncToCalendar = val;
                          });
                        }),
                  )),
              SizedBox(height: 10),
              Material(
                elevation: 2,
                color: Colors.white,
                child: TextFormField(
                  maxLines: 4,
                  focusNode: _notesFocusNode,
                  controller: _notesEditingController,
                  decoration: InputDecoration(
                      labelText: 'Add notes for your appointment'),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text('Save'.toUpperCase()),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print('save the data');
                            _appointmentProvider
                                .createAppointment(
                                    name: _descriptionEditingController.text,
                                    profession:
                                        _professionEditingController.text,
                                    date: _dateEditingController.text,
                                    time: timeEditingController.text,
                                    additionalNotes:
                                        _notesEditingController.text,
                                    syncToCalendar: _syncToCalendar)
                                .then((value) {
                              if (!value) {
                                print('bosssssssssss');
                                Navigator.pop(context);
                              } else {
                                print('Error while submitting data');
                              }
                            });
                          } else {}
                        }),
                  )),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
