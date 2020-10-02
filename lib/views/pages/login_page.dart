import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneTextEditingController =
  TextEditingController();
  final TextEditingController _codeTextEditingController =
  TextEditingController();
  // static CountryCode _countryCode = CountryCode.fromCode('TZ');

  String phoneNumber = '';

  UserCredential _userCredential;

  bool _initialized, _error;

  bool _sendingCode = false;
  bool _sendingPhone = false;

  void initializeFlutterFire() async {
    print('XXXXX: Initializing flutter');
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();

      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print('Error in initializing app ${e.toString()}');
      setState(() {
        _error = true;
      });
    }
  }

  Widget _pageContent;
  String _verificationId;

  @override
  void initState() {
    initializeFlutterFire();
    _pageContent = _enterPhone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
         decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/pregnancy.jpg'),fit: BoxFit.fitHeight)),
         child: Center(child: _pageContent),
      ),
    );
  }

  Widget _enterCode() {
    return Column(
      children: [
        // Image.asset('assets/decorative_friends.png'),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink, width: 2),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: TextField(
            controller: _codeTextEditingController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 300,
          height: 50,
          child: RaisedButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.pink,
            onPressed: () {
              setState(() {
                _sendingCode = true;
              });
              signIn();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => HomePage()));
            },
            child: _sendingCode
                ? CircularProgressIndicator()
                : Text(
              'VERIFY',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Widget _enterPhone() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset('assets/decorative_friends.png'),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink, width: 2),
            borderRadius: BorderRadius.circular(50.0),
            // borderSide: BorderSide(width: 50.0),
          ),
          width: 300,
          height: 50,
          child: IntlPhoneField(
            countryCodeTextColor: Colors.white,
            controller: _phoneTextEditingController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: TextStyle(color: Colors.white),
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(),
              // ),
            ),
            initialCountryCode: 'TZ',
            onChanged: (phone) {
              phoneNumber = phone.completeNumber;
              print(phone.completeNumber);
              print('Controller Text: ${_phoneTextEditingController.text}');
            },
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          height: 50,
          width: 300,
          child: RaisedButton(
            onPressed: () => _requestVerificationCode(context),
            color: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            child: _sendingPhone
                ? CircularProgressIndicator()
                : Text(
              'SUBMIT',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        SizedBox(height: 30.0),
      ],
    );
  }

  _requestVerificationCode(BuildContext context) async {
    String _phone = phoneNumber;//_countryCode.dialCode + _phoneTextEditingController.text;

    setState(() {
      _sendingPhone = true;
    });

    FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: 90),
        phoneNumber: _phone,
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  _verificationCompleted(PhoneAuthCredential credential) {
    print("XXXXXXXXXXXXXXXXX");
    print('Verification Completed');
    setState(() {
      _sendingPhone = false;
      _sendingCode = false;
    });

    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((UserCredential userCredential) {
      print("User Phone: " + userCredential.user.phoneNumber);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  _codeSent(String verificationId, int forceResendingToken) {
    print("XXXXXXXXXXXXXXXXX");
    print('Verification Code Sent');
    setState(() {
      _sendingPhone = false;
      _verificationId = verificationId;
      _pageContent = _enterCode();
    });
    // otpDialogBox(context).then((value) {});
  }

  _verificationFailed(FirebaseAuthException exception) {
    print("XXXXXXXXXXXXXXXXX");
    print('Verification Failed');
    setState(() {
      _sendingPhone = false;
      _sendingCode = false;
    });
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    setState(() {
      _sendingPhone = false;
      _sendingCode = false;
    });
    print("XXXXXXXXXXXXXXXXX");
    print('Verification Timedout');
  }

  String otp;

  Future<void> signIn() async {
    print("XXXXXXXXXXXXXXXXX");
    print('Sending code ${_codeTextEditingController.text} ');
    setState(() {
      _sendingCode = true;
    });
    UserCredential credential = await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _codeTextEditingController.text,
    ));

    if (credential.user != null) {
      print("Auth User Phone: " + credential.user.phoneNumber);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
