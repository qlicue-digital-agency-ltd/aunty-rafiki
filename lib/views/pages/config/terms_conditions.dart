import 'dart:async';

import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';

import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:aunty_rafiki/views/components/loader/loading.dart';
import 'package:aunty_rafiki/views/components/logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsConditionPage extends StatefulWidget {
  @override
  _TermsConditionPageState createState() => _TermsConditionPageState();
}

class _TermsConditionPageState extends State<TermsConditionPage> {
  @override
  Widget build(BuildContext context) {
    bool _loading = false;
    final size = MediaQuery.of(context).size;
    final _utilityProvider = Provider.of<UtilityProvider>(context);

    final _configProvider = Provider.of<ConfigProvider>(context);
    void itemChange(bool val, int index) {
      _utilityProvider.setItemChange = index;
    }

    List<Widget> _listBody = [
      RichText(
          text: TextSpan(children: [
        TextSpan(
            text: Languages.of(context).labelTermsAgreeInfo,
            style: TextStyle(
              color: Colors.black54,
            )),
        TextSpan(
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            text: Languages.of(context).labelTermsPrivacyInfo,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL(
                    'https://auntierafiki.co.tz/legal/update/privacy-policy');
              }),
        TextSpan(
            text: Languages.of(context).labelTermsAndInfo,
            style: TextStyle(
              color: Colors.black54,
            )),
        TextSpan(
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            text: Languages.of(context).labelTermsUseInfo,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL(
                    'https://auntierafiki.co.tz/legal/update/terms-of-use');
              }),
      ])),
      RichText(
          text: TextSpan(children: [
        TextSpan(
            style: TextStyle(
              color: Colors.black54,
            ),
            text: Languages.of(context).labelDeclarationOne),
        TextSpan(
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            text: Languages.of(context).labelTermsPrivacyInfo,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL(
                    'https://auntierafiki.co.tz/legal/update/privacy-policy');
              }),
      ])),
      RichText(
          text: TextSpan(children: [
        TextSpan(
            style: TextStyle(
              color: Colors.black54,
            ),
            text: Languages.of(context).labelDeclarationTwo),
        TextSpan(
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            text: Languages.of(context).labelDeclarationThree,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchURL(
                    'https://auntierafiki.co.tz/legal/update/personal-data');
              }),
        TextSpan(
            style: TextStyle(
              color: Colors.black54,
            ),
            text: Languages.of(context).labelDeclarationFour),
      ])),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomScrollView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                  Center(
                    child: AppLogo(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Auntie Rafiki',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((_, index) {
                return ListTile(
                    leading: Checkbox(
                        value: _utilityProvider.checkBoxList[index].isCheck,
                        onChanged: (bool val) {
                          itemChange(val, index);
                        }),
                    title: _listBody[index]);
              }, childCount: _utilityProvider.checkBoxList.length)),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              text: Languages.of(context).labelDisclaimer),
                          TextSpan(
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              text: " support@auntierafiki.co.tz ",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURLEmail(
                                      'https://auntierafiki.co.tz/legal/update/personal-data');
                                }),
                        ])),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 60, right: 60),
                    width: double.infinity / 2,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: _loading
                          ? Loading()
                          : Text(
                              _utilityProvider.configTerms == ConfigTerms.ALL
                                  ? Languages.of(context).labelNextButton
                                  : Languages.of(context).labelSelectAllButton,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                      onPressed: () {
                        if (_utilityProvider.configTerms == ConfigTerms.ALL) {
                          setState(() {
                            _loading = true;
                          });
                          Timer(Duration(milliseconds: 2000), () {
                            _configProvider.setConfigurationStep =
                                Configuration.SignUp;
                            _utilityProvider
                                .storeTerms(_utilityProvider.checkBoxList)
                                .then((value) {
                              Navigator.of(context)
                                  .pushReplacementNamed(landingPage);
                            });
                            setState(() {
                              _loading = false;
                            });
                          });
                        } else {
                          _utilityProvider.selectAllTerms();
                        }
                      },
                    ),
                  ),
                  _utilityProvider.configTerms == ConfigTerms.ALL
                      ? Container()
                      : TextButton(
                          onPressed: _utilityProvider.configTerms ==
                                  ConfigTerms.NON
                              ? null
                              : () {
                                  setState(() {
                                    _loading = true;
                                  });
                                  Timer(Duration(milliseconds: 2000), () {
                                    _configProvider.setConfigurationStep =
                                        Configuration.SignUp;
                                    _utilityProvider
                                        .storeTerms(
                                            _utilityProvider.checkBoxList)
                                        .then((value) {
                                      Navigator.of(context)
                                          .pushReplacementNamed(landingPage);
                                    });
                                    setState(() {
                                      _loading = false;
                                    });
                                  });
                                },
                          child: _loading
                              ? Loading(
                                  color: Colors.pink,
                                )
                              : Text(Languages.of(context).labelNextButton)),
                  SizedBox(
                    height: 40,
                  ),
                ]),
              ),
            ]),
      ),
    );
  }

  _launchURLEmail(url) async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'support@auntierafiki.co.tz',
        queryParameters: {'subject': ''});
    launch(_emailLaunchUri.toString());
  }
    void _launchURL(String uri) async {
    String url = uri;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch';
    }
  }
}
