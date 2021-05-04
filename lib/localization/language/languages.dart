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
  String get labelAddAppointmentButton;
  String get labelSaveButton;
  String get labelViewAllButton;

//onboarding

  String get labelTrackerInfo;
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

//Profile
  String get labelProfileTitle;
  String get labelMotherName;
  String get labelMotherNameQuestion;
  String get labelFullName;

  //pregnancy weeks
  String get labelPregnancyWeeksTitle;
  String get labelWeeks;
  String get labelDays;
  String get labelCheckButtonIDontRember;
  String get labelNoPregnancyWeeksTitle;
  String get labelNoPregnancyWeeksSubtitle;
  String get labelDateTitle;

  //Mother Birthday
  String get labelMotherBirthdayTitle;

  //Motherhood Information
  String get labelMotherhoodInformationTitle;
  String get labelGravida;
  String get labelEverHadAMiscarriage;
  String get labelWeeksOfMiscarriage;
  String get labelNumberOfTimesYouGaveBirth;
  String get labelBirthByOperation;

  //Motherhood Information
  String get labelMoreInformationTitle;
  String get labelHaemoglobinLevel;
  String get labelLastCheckHaemoglobinLevel;
  String get labelStartedClinic;
  String get labelUsingMedication;
  String get labelTetanusVacination;
  String get labelNumberTetanusVacination;
  String get labelDateLastTetanusVacination;
  String get labelDateNextTetanusVacination;

  //LEBELS
  String get labelYes;
  String get labelNo;
  String get labelSearch;

  //Main App
  String get labelTracker;
  String get labelChat;
  String get labelBloodLevel;
  String get labelMore;

  //more
  String get labelFood;
  String get labelAppointments;
  String get labelHospitalBag;
  String get labelTimeline;
  String get labelHivMOthers;

  //hospital bags
  String get labelMotherBag;
  String get labelBabyBag;
  String get labelPartnerBag;
  String get labelItemsPacked;

  //Tabs
  String get labelSuggesitionTab;
  String get labelItemsTab;
  String get labelGroupTab;
  String get labelChatsTab;
  String get labelCongratulationsItemsPacked;

  //No Items Tile
  String get labelNoItemTileGroup;
  String get labelNoItemTileTracker;
  String get labelNoItemTileBloodLevel;
  String get labelNoItemTileAppointments;
  String get labelNoItemTileContent;

  //Appointments
  String get labelAppointmentName;
  String get labelEnterAppointmentName;
  String get labelAddAppointmentNotes;

  //Blood level
  String get labelEnterBloodLevel;
  String get labelAddBloodLevel;
   String get labelBloodLevelTitle;
}
