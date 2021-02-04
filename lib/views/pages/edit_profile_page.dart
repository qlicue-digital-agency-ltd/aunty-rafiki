import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/text-field/editor_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FocusNode _fullnameFocusNode = FocusNode();
  final FocusNode _nicknameFocusNode = FocusNode();
  final FocusNode _yearOfBirthFocusNode = FocusNode();

  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _yearOfBirthController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  bool _onEditFullname = false;
  bool _onEditNickname = false;
  bool _onEditYearOfBirth = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String _title = 'Edit Profile';

    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
                child: InkWell(
              onTap: () {
                _authProvider.openFileExplorer();
              },
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width / 2,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      _authProvider.files.isEmpty
                          ? CircleAvatar(
                              radius: 60,
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(_authProvider.files[0]),
                                      fit: BoxFit.cover)),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )),

            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
              child: EditorTextField(
                icon: Icons.person,
                textEditingController: _fullnameController,
                title: _authProvider.currentUser.displayName,
                validator: (val) {
                  if (val.isEmpty)
                    return 'Enter fullname';
                  else
                    return null;
                },
                onEditTap: (val) {
                  print('val=> $val');
                  setState(() {
                    _onEditFullname = val;
                    if (val) {
                      _fullnameController.text =
                          _authProvider.currentUser.displayName;
                    } else {
                      _fullnameController.text = '';

                      ///TODO: SAVE THE CHANGED DATA ...
                    }
                  });
                  //   _onEditFullname = val;
                },
                onEdit: _onEditFullname,
                focusNode: _fullnameFocusNode,
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
              child: EditorTextField(
                icon: Icons.local_hospital,
                textEditingController: _nicknameController,
                title: _authProvider.currentUser.nameInitials,
                validator: (val) {
                  if (val.isEmpty)
                    return 'Enter nickname';
                  else
                    return null;
                },
                onEditTap: (val) {
                  print('val=> $val');
                  setState(() {
                    _onEditNickname = val;
                    if (val) {
                      _nicknameController.text =
                          _authProvider.currentUser.nameInitials;
                    } else {
                      _nicknameController.text = '';

                      ///TODO: SAVE THE CHANGED DATA ...
                    }
                  });
                  //   _onEditFullname = val;
                },
                onEdit: _onEditNickname,
                focusNode: _nicknameFocusNode,
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
              child: EditorTextField(
                icon: Icons.calendar_today,
                textEditingController: _yearOfBirthController,
                title: '${_authProvider.currentUser.yearOfBirth}',
                validator: (val) {
                  if (val.isEmpty)
                    return 'Enter year of birth';
                  else
                    return null;
                },
                onEditTap: (val) {
                  print('val=> $val');
                  setState(() {
                    _onEditYearOfBirth = val;
                    if (val) {
                      _yearOfBirthController.text =
                          _authProvider.currentUser.yearOfBirth.toString();
                    } else {
                      _yearOfBirthController.text = '';

                      ///TODO: SAVE THE CHANGED DATA ...
                    }
                  });
                  //   _onEditFullname = val;
                },
                onEdit: _onEditYearOfBirth,
                focusNode: _yearOfBirthFocusNode,
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Row(
            //   children: [
            //     Expanded(
            //         child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //       child: RaisedButton(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(25.0),
            //         ),
            //         padding: EdgeInsets.all(16.0),
            //         color: Theme.of(context).primaryColor,
            //         textColor: Colors.white,
            //         onPressed: _authProvider.files.isNotEmpty
            //             ? () {
            //                 if (_formKey.currentState.validate()) {
            //                   _authProvider.updateProfileTask(
            //                       displayName: _nicknameController.text,
            //                       age: _yearOfBirthController.text);
            //                 }
            //               }
            //             : null,
            //         child: Text('Save'),
            //       ),
            //     )),
            //   ],
            // )
          ],
        ),
      )),
    );
  }
}
