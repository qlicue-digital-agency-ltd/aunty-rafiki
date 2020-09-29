import 'package:flutter/material.dart';

class AddAppointmentPage extends StatelessWidget {
  FocusNode _descriptionFocusNode = FocusNode();
  FocusNode _notesFocusNode = FocusNode();

  TextEditingController _descriptionEditingController = TextEditingController();
  TextEditingController _notesEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Appointment')),
      body: SingleChildScrollView(
          child: Form(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Material(
                elevation: 2,
                color: Colors.white,
                child: TextFormField(
                  focusNode: _descriptionFocusNode,
                  controller: _descriptionEditingController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: (){
                  print('object');
                } ,child: Material(
                  elevation: 2,
                  color: Colors.white,
                  child: TextFormField(
                    focusNode: _descriptionFocusNode,
                    controller: _descriptionEditingController,
                    decoration: InputDecoration(labelText: 'Profession'),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Submitß"),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Text("Open Popup"),
        ),
      ),
    );
  }
}
