import 'dart:async';

import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/views/components/logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class ConfirmResetCodePage extends StatefulWidget {
  @override
  _ConfirmResetCodePageState createState() => _ConfirmResetCodePageState();
}

class _ConfirmResetCodePageState extends State<ConfirmResetCodePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  double divider = 3;
  String passwordText = '';

  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController()
    ..text = "";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor
          ])),
        ),
        preferredSize: Size(double.infinity, 50),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AppLogo(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Confirmation Code',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Enter the code sent to ",
                      children: [
                        TextSpan(
                            text: _authProvider.phoneNumber.completeNumber,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      length: 6,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 3) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        inactiveColor: Theme.of(context).primaryColor,
                        inactiveFillColor: Colors.white,
                        selectedColor: Colors.teal.shade900,
                        selectedFillColor: Theme.of(context).accentColor,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: hasError
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.teal.shade50,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      appContext: context,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: TextStyle(
                      color: Colors.pink,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    child: Text("Clear"),
                    onPressed: () {
                      textEditingController.clear();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                          text: " RESEND",
                          recognizer: onTapRecognizer,
                          style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontSize: 16))
                    ]),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: Theme.of(context).primaryColor),
                          child: FlatButton(
                            child: Text(
                              "VERIFY".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            onPressed: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              if (formKey.currentState.validate()) {
                                // conditions for validating
                                if (currentText.length != 6) {
                                  errorController.add(ErrorAnimationType
                                      .shake); // Triggering error shake animation
                                  setState(() {
                                    hasError = true;
                                  });
                                } else {
                                  print(currentText);
                                  _authProvider
                                      .signIn(smsCode: currentText)
                                      .then((credential) {
                                    if (credential.user != null) {
                                      print("Auth User Phone: " +
                                          credential.user.phoneNumber);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    }
                                  });
                                  setState(() {
                                    hasError = false;
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text("Aye!!"),
                                      duration: Duration(seconds: 2),
                                    ));

                                    // _authProvider
                                    //     .createNewPassword(
                                    //         mobile: widget.phoneNumber,
                                    //         password:
                                    //             _passwordTextEditingController
                                    //                 .text,
                                    //         code: currentText)
                                    //     .then((status) {
                                    //   Navigator.pushReplacementNamed(
                                    //       context, landingPageRoute);
                                    // });
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget _enterCode() {
//   return Column(
//     children: [
//       // Image.asset('assets/decorative_friends.png'),
//       SizedBox(
//         height: 20,
//       ),
//       Container(
//         height: 50,
//         width: 300,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.pink, width: 2),
//           borderRadius: BorderRadius.circular(50.0),
//         ),
//         child: TextField(
//           controller: _codeTextEditingController,
//           decoration: InputDecoration(
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20))),
//         ),
//       ),
//       SizedBox(height: 20),
//       Container(
//         width: 300,
//         height: 50,
//         child: RaisedButton(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           color: Colors.pink,
//           onPressed: () {
//             setState(() {
//               _sendingCode = true;
//             });
//             //signIn();
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (BuildContext context) => HomePage()));
//           },
//           child: _sendingCode
//               ? CircularProgressIndicator()
//               : Text(
//                   'VERIFY',
//                   style: TextStyle(color: Colors.white),
//                 ),
//         ),
//       )
//     ],
//   );
// }
