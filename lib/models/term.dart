import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermModel {
  int id;
  Widget body;
  bool isCheck;

  TermModel({this.id, this.body, this.isCheck});

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
                    _launchURL('https://qlicue.co.tz/');
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
                    _launchURL('https://qlicue.co.tz/');
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
                    'I agree to the processing of my personal health data for providing me the Aunty Rafiki app functions. See more in our'),
            TextSpan(
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                text: " Privacy Policy ",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchURL('https://qlicue.co.tz/');
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
              text: 'I agree that Aunty Rafiki may use'),
            TextSpan(
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                text: " my personal data ",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchURL('https://qlicue.co.tz/');
                  }),
            TextSpan(
               style: TextStyle(
                  color: Colors.black54,
                ),
                text:
                    '(except health data) to send me product or services offerings via email, Aunty Rafiki app or marketing partners.'),
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
