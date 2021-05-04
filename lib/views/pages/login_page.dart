import 'dart:ui';

import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/logo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                Expanded(
                  child: Text(
                    Languages.of(context).labelVerifyYourPhoneNumber,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.pink, fontSize: size.width * 0.05),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: IntlPhoneField(
                countryCodeTextColor: Colors.black,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(13),
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.singleLineFormatter,
                  //_phoneNumberFormatter,
                ],
                style: TextStyle(color: Colors.black),
                initialCountryCode: 'TZ',
                onChanged: (phone) {
                  _authProvider.setPhoneNumber = phone;
                  setState(() {
                    _phoneNumber = phone.number;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  if (!_authProvider.isSendingPhone) {
                    if (_phoneNumber.isNotEmpty)
                      _authProvider.requestVerificationCode().then((value) {
                        if (!value) {
                          Navigator.pushNamed(context, confirmationPage);
                        }
                      });
                  }
                },
                child: _authProvider.isSendingPhone
                    ? Loading()
                    : Text(
                        Languages.of(context).labelNextButton,
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
