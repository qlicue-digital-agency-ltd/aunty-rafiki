import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';

import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';
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
    final size = MediaQuery.of(context).size;
    final _utilityProvider = Provider.of<UtilityProvider>(context);

    final _configProvider = Provider.of<ConfigProvider>(context);
    void itemChange(bool val, int index) {
      _utilityProvider.setItemChange = index;
    }

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
                    title: _utilityProvider.checkBoxList[index].body);
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
                              text:
                                  '* You can withdraw your consent anytime by contacting by contacting us at '),
                          TextSpan(
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              text: " support@auntierafiki.co.tz ",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                      'https://auntierafiki.co.tz/personal-data');
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
                      child: Text(
                        _utilityProvider.configTerms == ConfigTerms.ALL
                            ? "NEXT"
                            : "Select All",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      onPressed: () {
                        if (_utilityProvider.configTerms == ConfigTerms.ALL) {
                          _utilityProvider
                              .storeTerms(_utilityProvider.checkBoxList)
                              .then((value) {
                            Navigator.of(context)
                                .pushReplacementNamed(loginPage);
                            _configProvider.setConfigurationStep =
                                Configuration.SignUp;
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
                                  _utilityProvider
                                      .storeTerms(_utilityProvider.checkBoxList)
                                      .then((value) {
                                    Navigator.of(context)
                                        .pushReplacementNamed(loginPage);
                                    _configProvider.setConfigurationStep =
                                        Configuration.SignUp;
                                  });
                                },
                          child: Text('NEXT')),
                  SizedBox(
                    height: 40,
                  ),
                ]),
              ),
            ]),
      ),
    );
  }

  _launchURL(url) async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'support@auntierafiki.co.tz',
        queryParameters: {'subject': ''});
    launch(_emailLaunchUri.toString());
  }
}
