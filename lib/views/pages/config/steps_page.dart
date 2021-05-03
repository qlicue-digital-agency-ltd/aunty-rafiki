import 'dart:io';

import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/localization/locale_constant.dart';
import 'package:aunty_rafiki/models/language_data.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:aunty_rafiki/views/components/steps/step_progress_view.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/more_info_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/mother_hood_info_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/name_screen.dart';

import 'package:aunty_rafiki/views/pages/config/steps/components/weeks_pregnancy_screen.dart';
import 'package:aunty_rafiki/views/pages/config/steps/components/year_of_birth_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepsPage extends StatefulWidget {
  @override
  _StepsPageState createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 150.0;

  Color _activeColor = Colors.pink;

  Color _inactiveColor = Colors.grey;

  TextStyle _headerStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final _configProvider = Provider.of<ConfigProvider>(context);

    List<Widget> _screens = [
      NameScreen(
        currentPage: 0,
        changePage: _configProvider.changePage,
      ),
      WeeksPregnancyScreen(
        currentPage: 1,
        changePage: _configProvider.changePage,
      ),
      YearOfBirthScreen(
        currentPage: 2,
        changePage: _configProvider.changePage,
      ),
      MotherhoodInfoScreen(
        currentPage: 3,
        changePage: _configProvider.changePage,
      ),
      MoreInfoScreen(
        currentPage: 4,
        changePage: _configProvider.changePage,
        scaffoldKey: _scafoldKey,
      ),
    ];

    List<String> _titles = [
      Languages.of(context).labelMotherName,
      Languages.of(context).labelPregnancyWeeksTitle,
      Languages.of(context).labelMotherBirthdayTitle,
      Languages.of(context).labelMotherhoodInformationTitle,
      Languages.of(context).labelMoreInformationTitle
    ];

//  if (index == 0) {
//       _title = "Mother's Name";
//     }
//     if (index == 1) {
//       _title = "Weeks of Pregnancy";
//     }
//     if (index == 2) {
//       _title = "Mother's Birthday";
//     }
//     if (index == 3) {
//       _title = "Motherhood Information";
//     }
//     if (index == 4) {
//       _title = "More Information";
//     }
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: _configProvider.currentPregPage == 1
            ? Container()
            : IconButton(
                icon: Icon(
                    Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
                onPressed: () {
                  if (_utilityProvider.knownPregnancy) {
                    _configProvider.backPage();
                  } else {}
                }),
        title: Text(
          Languages.of(context).labelProfileTitle,
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          PopupMenuButton<LanguageData>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black54,
              ),
              onSelected: (LanguageData language) {
                changeLanguage(context, language.languageCode);
              },
              itemBuilder: (BuildContext context) => LanguageData.languageList()
                  .map<PopupMenuEntry<LanguageData>>(
                    (e) => PopupMenuItem<LanguageData>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: TextStyle(),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: StepProgressView(
                    steps: _screens.length,
                    curStep: _configProvider.currentPregPage,
                    height: _stepProgressViewHeight,
                    width: MediaQuery.of(context).size.width,
                    dotRadius: _stepCircleRadius,
                    activeColor: _activeColor,
                    inactiveColor: _inactiveColor,
                    headerStyle: _headerStyle,
                    stepsStyle: _stepStyle,
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.only(
                      top: 48.0,
                      left: 24.0,
                      right: 24.0,
                    ),
                    title: _titles[_configProvider.currentPregPage - 1],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _screens[_configProvider.currentPregPage - 1],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
