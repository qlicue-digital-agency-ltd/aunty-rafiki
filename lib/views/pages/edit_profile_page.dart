import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/text-field/label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FocusNode _fullnameFocusNode = FocusNode();

  TextEditingController _fullnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Center(
              child: InkWell(
            onTap: () {
              _authProvider.chooseAmImage();
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
                    _authProvider.pickedImage == null
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
                                    image: FileImage(_authProvider.pickedImage),
                                    fit: BoxFit.cover)),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' Select an Image!',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          )),
          Padding(
            padding: EdgeInsets.only(
                top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
            child: LabelTextfield(
              prefixIcon: FontAwesomeIcons.user,
              message: 'Please enter your fullname',
              maxLines: 1,
              hitText: 'Fullname',
              labelText: null,
              focusNode: _fullnameFocusNode,
              textEditingController: _fullnameController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      )),
    );
  }
}
