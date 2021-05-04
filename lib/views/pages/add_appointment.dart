import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_date_field.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_selector_field.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_text_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAppointmentPage extends StatefulWidget {
  @override
  _AddAppointmentPageState createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  FocusNode _notesFocusNode = FocusNode();

  String date = 'Date';
  String time = 'Time';
  bool _syncToCalendar = false;
  String valueDate = '';
  String valueToValidate3 = '';
  String valueSaved3 = '';
  String valueTime = '';
  String valueToValidate4 = '';
  String _selectedProfession = "Doctor";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _descriptionEditingController = TextEditingController();

  TextEditingController _notesEditingController = TextEditingController();

  TextEditingController _dateEditingController;
  TextEditingController _timeEditingController;
  AvailableProfessions _character = AvailableProfessions.doctor;

  @override
  void initState() {
    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _timeEditingController = TextEditingController(text: '$lsHour:$lsMinute');
    _getValue();
    super.initState();
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
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(Languages.of(context).labelAddAppointmentButton, style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              IconTextField(
                icon: Icons.assignment,
                textEditingController: _descriptionEditingController,
                title: Languages.of(context).labelAppointmentName,
                validator: (val) {
                  if (val.isEmpty)
                    return Languages.of(context).labelEnterAppointmentName;
                  else
                    return null;
                },
              ),
              IconDateField(
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
                title: Languages.of(context).labelDateTitle,
                dateMask: "EEEE, MMMM d, y",
                type: DateTimePickerType.date,
              ),
              IconDateField(
                onChage: (val) {},
                onSaved: (val) {},
                onValidate: (val) {
                  setState(() => valueToValidate4 = val);
                  return null;
                },
                textEditingController: _timeEditingController,
                icon: Icons.access_time,
                title: 'Time',
                dateMask: 'dd/MM/yyyy',
                type: DateTimePickerType.time,
              ),
              IconSelectorField(
                onTap: () {
                  _showDialog();
                },
                title: _selectedProfession,
                icon: Icons.assignment_ind,
              ),
              SizedBox(
                height: 10,
              ),
              // IconSwitchField(
              //   icon: Icons.alarm_on,
              //   onChanged: (val) {
              //     setState(() {
              //       _syncToCalendar = val;
              //     });
              //   },
              //   syncToCalendar: _syncToCalendar,
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(Languages.of(context).labelAddAppointmentNotes),
                ],
              ),
              Container(
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
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _appointmentProvider.isSubmittingData
                            ? Loading()
                            : Text(
                                Languages.of(context).labelSaveButton.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            print('save the data');
                            _appointmentProvider
                                .createAppointment(
                                    name: _descriptionEditingController.text,
                                    profession: _selectedProfession,
                                    date: _dateEditingController.text,
                                    time: _timeEditingController.text,
                                    additionalNotes:
                                        _notesEditingController.text,
                                    syncToCalendar: _syncToCalendar)
                                .then((value) {
                              if (!value) {
                                Navigator.pop(context);
                              } else {
                                print('Error while submitting data');
                              }
                            });
                          } else {}
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:20)
            ],
          ),
        ),
      )),
    );
  }
}
