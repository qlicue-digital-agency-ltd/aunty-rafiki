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
  String get labelTracker => "Tracker";
  @override
  String get labelTrackerInfo =>
      "Auntie Rafiki tracks your daily pregancy growth and changes";
  @override
  String get labelChat => "Chat";
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

  //titles..
  @override
  String get labelVerifyYourPhoneNumber => "Verify your phone number";
  @override
  String get labelConfirmationCode => "Confirmation Code";
  @override
  String get labelEnterTheCodeSentTo => "Enter the code sent to\t";
  @override
  String get labelDidNotReceiveTheCode => "Didn't receive the code?\t";
}
