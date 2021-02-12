import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';

import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsConditionPage extends StatefulWidget {
  @override
  _TermsConditionPageState createState() => _TermsConditionPageState();
}

class _TermsConditionPageState extends State<TermsConditionPage> {
  @override
  Widget build(BuildContext context) {
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
                    height: 100,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/icons/aunty_rafiki.png',
                      height: 100.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'Aunty Rafiki',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((_, index) {
                return ListTile(
                    onTap: () {
                      itemChange(
                          !_utilityProvider.checkBoxList[index].isCheck, index);
                    },
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
                    child: Text(
                      '*You can withdraw your consent anytime by contacting by contacting us at support@auntyrafiki.co.tz',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 60, right: 60),
                    width: double.infinity / 2,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      color: Colors.pink[400],
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
                      : FlatButton(
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
}
