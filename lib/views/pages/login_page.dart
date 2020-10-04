import 'dart:ui';

import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/logo.dart';
import 'package:aunty_rafiki/views/components/text-field/mobile_text_field.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            AppLogo(),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verify your phone number',
                  style: TextStyle(color: Colors.pink, fontSize: 24),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MobileTextfield(
              phoneTextEditingController: _phoneTextEditingController,
              onChange: (phone) {
                print(phone);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50,
              width: 300,
              child: RaisedButton(
                onPressed: () => _authProvider.requestVerificationCode(
                    codeAuto: null,
                    phoneNumber: null,
                    verificationCompleted: null,
                    verificationFailed: null,
                    code: null),
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                child: _authProvider.sendingPhone
                    ? CircularProgressIndicator()
                    : Text(
                        'NEXT',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
