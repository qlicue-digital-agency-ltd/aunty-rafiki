import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:aunty_rafiki/providers/blood_level_provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBloodLevelPage extends StatefulWidget {
  @override
  _AddBloodLevelPageState createState() => _AddBloodLevelPageState();
}

class _AddBloodLevelPageState extends State<AddBloodLevelPage> {
  FocusNode _valueFocusNode = FocusNode();

  String date = 'Date';

  String valueDate = '';
  String valueToValidate3 = '';
  String valueSaved3 = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _valueEditingController = TextEditingController();

  TextEditingController _dateEditingController;

  @override
  void initState() {
    _getValue();
    super.initState();
  }

  /// from a data base sqlite or from a API
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _dateEditingController.text = '22-11-2020';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    final _bloodLevelProvider = Provider.of<BloodLevelProvider>(context);
    _dateEditingController = TextEditingController(
        text: _appointmentProvider.selectedCalendarDay.toString());
    return Scaffold(
      appBar: AppBar(title: Text('Add Blood Level')),
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
                        return 'Enter the blood level';
                      else
                        return null;
                    },
                    focusNode: _valueFocusNode,
                    controller: _valueEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.local_hospital),
                        labelText: 'Blood Level',
                        suffix: Text('Hm/mml')
                        
                        ),
                        
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
                            _bloodLevelProvider
                                .postBloodLevel(
                              quantity: double.parse(_valueEditingController.text),
                              date: _dateEditingController.text,
                            )
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
