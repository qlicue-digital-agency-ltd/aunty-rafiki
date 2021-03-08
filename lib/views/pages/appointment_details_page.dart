import 'package:aunty_rafiki/models/appointment.dart';
import 'package:aunty_rafiki/views/components/text-field/icon_text_field.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsPage extends StatefulWidget {
  final Appointment appointment;

  AppointmentDetailsPage({Key key, @required this.appointment})
      : super(key: key);

  @override
  _AppointmentDetailsPageState createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  TextEditingController _descriptionEditingController = TextEditingController();
  bool _editAppointmetName = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                ],
              ),
            )),
          )
        ]),
      ),
    );
  }
}
