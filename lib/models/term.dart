import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermModel {
  int id;
  Widget body;
  bool isCheck;

  TermModel({this.id, this.body, this.isCheck});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'body': body, 'isCheck': isCheck, 'id': id};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static List<TermModel> getUsers() {
    return <TermModel>[
      TermModel(
          id: 1,
          body: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'I agree to the',
                style: TextStyle(
                  color: Colors.black54,
                )),
            TextSpan(
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                text: " Privacy Policy ",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchURL('https://auntierafiki.co.tz/legal/update/privacy-policy');
                  }),
            TextSpan(
                text: ' and ',
                style: TextStyle(
                  color: Colors.black54,
                )),
            TextSpan(
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                text: "Terms of Use.",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchURL('https://auntierafiki.co.tz/legal/update/terms-of-use');
                  }),
          ])),
          isCheck: false),
      TermModel(
          id: 2,
          body: RichText(
              text: TextSpan(children: [
            TextSpan(
                style: TextStyle(
                  color: Colors.black54,
                ),
                text:
                    'I agree to the processing of my personal health data for providing me the Auntie Rafiki app functions. See more in our'),
            TextSpan(
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                text: " Privacy Policy ",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchURL('https://auntierafiki.co.tz/legal/update/privacy-policy');
                  }),
          ])),
          isCheck: false),
      TermModel(
          id: 3,
          body: RichText(
              text: TextSpan(children: [
            TextSpan(
                style: TextStyle(
                  color: Colors.black54,
                ),
                text: 'I agree that Auntie Rafiki may use'),
            TextSpan(
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                text: " my personal data ",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchURL('https://auntierafiki.co.tz/legal/update/personal-data');
                  }),
            TextSpan(
                style: TextStyle(
                  color: Colors.black54,
                ),
                text:
                    '(except health data) to send me product or services offerings via email, Auntie Rafiki app or marketing partners.'),
          ])),
          
          
          isCheck: false),
    ];
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
