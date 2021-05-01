import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get labelWelcome;

  String get labelInfo;

  String get labelSelectLanguage;

//onboarding
  String get labelNextButton;
  String get labelGetStartedButton;

  String get labelTracker;

  String get labelTrackerInfo;

  String get labelChat;

  String get labelChatInfo;

  String get labelHealth;

  String get labelHealthInfo;

  String get labelSecurity;

  String get labelSecurityInfo;

  String get labelCloudBased;

  String get labelCloudBasedInfo;
}
