import 'dart:async';

import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/providers/mother_provider.dart';
import 'package:aunty_rafiki/views/components/logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ConfirmResetCodePage extends StatefulWidget {
  @override
  _ConfirmResetCodePageState createState() => _ConfirmResetCodePageState();
}

class _ConfirmResetCodePageState extends State<ConfirmResetCodePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  double divider = 3;
  String passwordText = '';

  TextEditingController textEditingController = TextEditingController()
    ..text = "";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";

  Timer _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final _confogProvider = Provider.of<ConfigProvider>(context);
    final _motherProvider = Provider.of<MotherProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                  Languages.of(context).labelConfirmationCode,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: Languages.of(context).labelEnterTheCodeSentTo,
                      children: [
                        TextSpan(
                            text: _authProvider.phoneNumber.completeNumber,
                            style: TextStyle(
                                color: Colors.black54,
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
                      keyboardType: TextInputType.number,
                      length: 6,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 3) {
                          return Languages.of(context).labelEnterTheCodeSentTo;
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
                  TextButton(
                    child: Text(
                      Languages.of(context).labelClearButton,
                      style: TextStyle(
                          color: textEditingController.text.isEmpty
                              ? Colors.black26
                              : Colors.pink),
                    ),
                    onPressed: () {
                      startTimer();
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
                    text: Languages.of(context).labelDidNotReceiveTheCode,
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                          text: Languages.of(context).labelResendButton +
                              (_start > 0
                                  ? "'\t'in $_start"
                                  : '\t' + Languages.of(context).labelNow),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                              _authProvider
                                  .requestVerificationCode()
                                  .then((value) {
                                if (!value) {
                                  Navigator.pushNamed(
                                      context, confirmationPage);
                                }
                              });
                              print('***************object*************');
                            },
                          style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      TextSpan(
                          text: "",
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
                          child: TextButton(
                            child: _authProvider.isVerifyingCode
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : Text(
                                    Languages.of(context)
                                        .labelVerifyButton
                                        .toUpperCase(),
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
                                    if (credential != null) {
                                      _authProvider
                                          .checkUserHasProfile()
                                          .then((value) {
                                        if (value) {
                                          _confogProvider.setConfigurationStep =
                                              Configuration.Done;
                                          Navigator.pushReplacementNamed(
                                              context, landingPage);
                                        } else {
                                          _confogProvider.setConfigurationStep =
                                              Configuration.Profile;

                                          _motherProvider.postMother();
                                          Navigator.pushReplacementNamed(
                                              context, createProfilePage);
                                        }
                                      });
                                      print("Auth User Phone: " +
                                          credential.user.phoneNumber);
                                    } else {
                                      errorController.add(ErrorAnimationType
                                          .shake); // Triggering error shake animation
                                      textEditingController.clear();
                                    }
                                  });
                                  setState(() {
                                    hasError = false;
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
