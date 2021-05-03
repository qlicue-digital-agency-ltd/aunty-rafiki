import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

//labels
  String get appName;

  String get labelWelcome;

  String get labelInfo;

  String get labelSelectLanguage;
  String get labelNow;

//Buttons
  String get labelNextButton;
  String get labelGetStartedButton;
  String get labelSelectAllButton;
  String get labelClearButton;
  String get labelResendButton;
   String get labelVerifyButton;

//onboarding
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

  //Terms and condition..

  String get labelTermsAgreeInfo;
  String get labelTermsPrivacyInfo;
  String get labelTermsAndInfo;
  String get labelTermsUseInfo;

  //Declaration...
  String get labelDeclarationOne;
  String get labelDeclarationTwo;
  String get labelDeclarationThree;
  String get labelDeclarationFour;
  String get labelDisclaimer;

  //titles..
  String get labelVerifyYourPhoneNumber;
  String get labelConfirmationCode;
  String get labelEnterTheCodeSentTo;
  String get labelDidNotReceiveTheCode;
}
