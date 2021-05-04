import 'languages.dart';

class LanguageEn extends Languages {
  @override
  String get appName => "Auntie Rafiki";

//labels
  @override
  String get labelWelcome => "Welcome";
  @override
  String get labelSelectLanguage => "Select Language";
  @override
  String get labelInfo => "For maternal and child health";
  @override
  String get labelNow => "now";

  //onboarding
  @override
  String get labelTrackerInfo =>
      "Auntie Rafiki tracks your daily pregancy growth and changes";

  @override
  String get labelChatInfo => "Auntie Rafiki connects you to a midwife, 24/7";
  @override
  String get labelCloudBased => "Cloud-Based";
  @override
  String get labelCloudBasedInfo =>
      "Auntie Rafiki lets you access your messages from multiple devices";
  @override
  String get labelHealth => "Health";
  @override
  String get labelHealthInfo =>
      "Auntie Rafiki carters for the health of you and your baby";
  @override
  String get labelSecurity => "Secure";
  @override
  String get labelSecurityInfo =>
      "Auntie Rafiki keeps your information and messages private and safe from attacks";

//Terms and conditions
  @override
  String get labelTermsAgreeInfo => "I agree to the\t";

  @override
  String get labelTermsPrivacyInfo => "Privacy Policy\t";

  @override
  String get labelTermsAndInfo => "and\t";

  @override
  String get labelTermsUseInfo => "Terms of Use.";

  //Declaration
  @override
  String get labelDeclarationOne =>
      "I agree with the processing of my personal health data to provide me a better user experience of Auntie Rafiki. See more in our\t";
  @override
  String get labelDeclarationTwo => "I agree that Auntie Rafiki may use\t";
  @override
  String get labelDeclarationThree => "my personal data\t";
  @override
  String get labelDeclarationFour =>
      "(except health data) to send me product or service offerings via email, Auntie Rafiki app, or marketing partners.\t";

  @override
  String get labelDisclaimer =>
      "*\tYou can withdraw your consent anytime by contacting us at\t";

//buttons
  @override
  String get labelNextButton => "Next";
  @override
  String get labelGetStartedButton => "Get Started";
  @override
  String get labelSelectAllButton => "Select All";
  @override
  String get labelClearButton => "Clear";
  @override
  String get labelResendButton => "Resend";
  @override
  String get labelVerifyButton => "Verify";
  @override
  String get labelAddAppointmentButton => "Add Appointment";
  @override
  String get labelSaveButton => "Save";
  @override
  String get labelViewAllButton => "View All";

  //titles..
  @override
  String get labelVerifyYourPhoneNumber => "Verify your phone number";
  @override
  String get labelConfirmationCode => "Confirmation Code";
  @override
  String get labelEnterTheCodeSentTo => "Enter the code sent to\t";
  @override
  String get labelDidNotReceiveTheCode => "Didn't receive the code?\t";

//Profile
  @override
  String get labelProfileTitle => "Profile";
  @override
  String get labelFullName => "Full Name";
  @override
  String get labelMotherName => "Mother's Name";
  @override
  String get labelMotherNameQuestion => "What is your name?";

  // Pregnancy Weeks
  @override
  String get labelPregnancyWeeksTitle => "Weeks of Pregnancy";
  @override
  String get labelWeeks => "WEEKS";
  @override
  String get labelDays => "DAYS";
  @override
  String get labelCheckButtonIDontRember => "I don't remember";
  @override
  String get labelNoPregnancyWeeksTitle =>
      "Don't worry Auntie Rafiki will help you determine the pregnancy week in another way";
  @override
  String get labelNoPregnancyWeeksSubtitle =>
      "Select the date of the first day of your last menstrual period";
  @override
  String get labelDateTitle => "Date";

  //Mother Birthday
  @override
  String get labelMotherBirthdayTitle => "Mother's Birthday";
  @override
  String get labelGravida => "Gravida";
  @override
  String get labelEverHadAMiscarriage => "Ever had a miscarriage?";
  @override
  String get labelWeeksOfMiscarriage =>
      "How many weeks was the pregnancy upon miscarriage?";
  @override
  String get labelBirthByOperation => "How many times have you given birth?";
  @override
  String get labelNumberOfTimesYouGaveBirth =>
      "How many times did you give birth by operation?";

  // More Information
  @override
  String get labelMoreInformationTitle => "More Information";
  @override
  String get labelHaemoglobinLevel => "Haemoglobin level";
  @override
  String get labelLastCheckHaemoglobinLevel =>
      "Last time you checked haemoglobin level";

  @override
  String get labelStartedClinic => "Have you started clinic?";

  @override
  String get labelUsingMedication => "Are you using any medication?";

  @override
  String get labelTetanusVacination => "Have you taken a tetanus vaccination?";

  @override
  String get labelNumberTetanusVacination =>
      "How many times have you had the tetanus vaccination?";
  @override
  String get labelDateLastTetanusVacination =>
      "Last time you had the tetanus vaccination";

  @override
  String get labelDateNextTetanusVacination =>
      "When is your next tetanus vaccination";

  // Motherhood Information
  @override
  String get labelMotherhoodInformationTitle => "Motherhood Information";

//LEBELS
  @override
  String get labelNo => "NO";
  @override
  String get labelYes => "YES";

  //mainAPP
  @override
  String get labelTracker => "Tracker";
  @override
  String get labelChat => "Chat";
  @override
  String get labelBloodLevel => "Blood Level";
  @override
  String get labelMore => "More";

  //more
  @override
  String get labelAppointments => "Appointments";
  @override
  String get labelFood => "Food";
  @override
  String get labelHivMOthers => "HIV Mothers";
  @override
  String get labelHospitalBag => "Hospital Bag";
  @override
  String get labelTimeline => "Timeline";

  //Hospital bags
  @override
  String get labelBabyBag => "Baby's Bag";

  @override
  String get labelMotherBag => "Mother's Bag";

  @override
  String get labelPartnerBag => "Birth partner's Bag";

  @override
  String get labelItemsPacked => "items packed";

  //Tabs
  @override
  String get labelChatsTab => "Chats";
  @override
  String get labelGroupTab => "Groups";
  @override
  String get labelItemsTab => "My Items";
  @override
  String get labelSuggesitionTab => "Suggestions";
  @override
  String get labelCongratulationsItemsPacked =>
      "Congratulations you have packed all items";

  //No Items Tile
  @override
  String get labelNoItemTileGroup => "You are not in any chat group yet";

  @override
  String get labelNoItemTileBloodLevel => "No blood levels";
  @override
  String get labelNoItemTileContent => "No Content";

  @override
  String get labelNoItemTileTracker =>
      "Tap to add the first day of your last menstrual period";
  @override
  String get labelNoItemTileAppointments => "No appointments to display";

//search
  @override
  String get labelSearch => "Search...";

  //Appointments...
  @override
  String get labelAddAppointmentNotes => "Add Notes";
  @override
  String get labelAppointmentName => "Appointment Title";
  @override
  String get labelEnterAppointmentName => "Enter Appointment Title";

//Blood Level
  @override
  String get labelAddBloodLevel => "Add blood level";
  @override
  String get labelEnterBloodLevel => "Enter blood level";
  @override
  String get labelBloodLevelTitle => "Blood Level";
}
