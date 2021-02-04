import 'package:aunty_rafiki/models/user.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/text-field/editor_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({Key key, @required this.user}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FocusNode _fullnameFocusNode = FocusNode();
  final FocusNode _nameInitialsFocusNode = FocusNode();

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _nameInitialsController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  bool _onEdit = false;
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
                icon: Icons.local_hospital,
                textEditingController: _textController,
                title: 'Blood Level',
                validator: (val) {
                  if (val.isEmpty)
                    return 'Enter the blood level';
                  else
                    return null;
                },
                onEditTap: (val) {
                  print('val=> $val');
                  setState(() {
                    _onEdit = val;
                    if (val) {
                      _textController.text = 'Blood Level';
                    } else {
                      _textController.text = '';

                      ///TODO: SAVE THE CHANGED DATA ...
                    }
                  });
                  //   _onEdit = val;
                },
                onEdit: _onEdit,
                focusNode: null,
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
            //                       displayName: _fullnameController.text,
            //                       nameInitials: _nameInitialsController.text);
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
