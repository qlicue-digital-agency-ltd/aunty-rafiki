import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/text-field/editor_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FocusNode _displayNameFocusNode = FocusNode();
  final FocusNode _nameInitialsFocusNode = FocusNode();
  final FocusNode _yearOfBirthFocusNode = FocusNode();

  TextEditingController nameInitials = TextEditingController();
  TextEditingController yearOfBirth = TextEditingController();
  TextEditingController displayName = TextEditingController();
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
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      _authProvider.files.isEmpty
                          ? InkWell(
                              onTap: () {
                                _authProvider.openFileExplorer();
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    _authProvider.currentUser.photoUrl != null
                                        ? NetworkImage(
                                            _authProvider.currentUser.photoUrl)
                                        : null,
                                radius: 60,
                                child: Center(
                                  child: _authProvider.currentUser.photoUrl !=
                                          null
                                      ? Text(
                                          'Edit',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Icon(
                                          Icons.add_a_photo,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _authProvider.openFileExplorer();
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(
                                                _authProvider.files[0]),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                FlatButton.icon(
                                    icon: Icon(Icons.save),
                                    textColor: Colors.pink,
                                    onPressed: () {
                                      _authProvider.saveProfileImage();
                                    },
                                    label: Text(
                                      'Save'.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
              child: EditorTextField(
                icon: Icons.person,
                textEditingController: displayName,
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
                    if (val) {
                      displayName.text = _authProvider.currentUser.displayName;
                      _onEditFullname = val;
                    } else {
                      _authProvider.updateProfile(
                          key: 'displayName', data: displayName.text);
                      _onEditFullname = val;
                      displayName.text = '';
                    }
                  });
                  //   _onEditFullname = val;
                },
                onEdit: _onEditFullname,
                focusNode: _displayNameFocusNode,
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
                textEditingController: nameInitials,
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
                    if (val) {
                      _onEditNickname = val;
                      nameInitials.text =
                          _authProvider.currentUser.nameInitials;
                    } else {
                      _authProvider.updateProfile(
                          key: 'nameInitials', data: nameInitials.text);
                      _onEditNickname = val;
                      nameInitials.text = '';
                    }
                  });
                  //   _onEditFullname = val;
                },
                onEdit: _onEditNickname,
                focusNode: _nameInitialsFocusNode,
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
                textEditingController: yearOfBirth,
                textInputType: TextInputType.number,
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
                    if (val) {
                      _onEditYearOfBirth = val;
                      yearOfBirth.text =
                          _authProvider.currentUser.yearOfBirth.toString();
                    } else {
                      _authProvider.updateProfile(
                          key: 'yearOfBirth',
                          data: int.parse(yearOfBirth.text));
                      _onEditYearOfBirth = val;
                      yearOfBirth.text = '';
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
            //                       displayName: nameInitials.text,
            //                       age: yearOfBirth.text);
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
