import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/localization/locale_constant.dart';
import 'package:aunty_rafiki/models/language_data.dart';
import 'package:aunty_rafiki/views/components/logo.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              AppLogo(),
              Text(
                Languages.of(context).labelWelcome,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                Languages.of(context).appName,
                style: TextStyle(fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              Text(
                Languages.of(context).labelInfo,
                style: TextStyle(fontSize: 10, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              _createLanguageDropDown()
            ],
          ),
        ),
      );

  _createLanguageDropDown() {
    return DropdownButton<LanguageData>(
      iconSize: 30,
      hint: Text(Languages.of(context).labelSelectLanguage),
      onChanged: (LanguageData language) {
        changeLanguage(context, language.languageCode);
      },
      items: LanguageData.languageList()
          .map<DropdownMenuItem<LanguageData>>(
            (e) => DropdownMenuItem<LanguageData>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(e.name)
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
