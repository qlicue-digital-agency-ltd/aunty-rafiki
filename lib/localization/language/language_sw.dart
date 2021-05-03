import 'languages.dart';

class LanguageSw extends Languages {
  //labels
  @override
  String get appName => "Auntie Rafiki";
  @override
  String get labelWelcome => "Karibu";
  @override
  String get labelSelectLanguage => "Chagua Lugha";
  @override
  String get labelNow => "sasa";
  @override
  String get labelInfo => "Kwa afya ya mama na mtoto";

//onboarding
  @override
  String get labelTracker => "Fatilia";
  @override
  String get labelTrackerInfo =>
      "Auntie Rafiki tunafatilia ukuwaji wa kila siku wa ujauzito wako.";
  @override
  String get labelChat => "Jumbe";
  @override
  String get labelChatInfo =>
      "Auntie Rafiki ina kuunganisha na mkunga wa kukusaidia masaa 24 kila siku";
  @override
  String get labelCloudBased => "Mtandaoni";
  @override
  String get labelCloudBasedInfo =>
      "Auntie Rafiki ina kuruhusu kupata taarifa zako kwa kutumia vifaa tofauti vya tehama";
  @override
  String get labelHealth => "Afya";
  @override
  String get labelHealthInfo =>
      "Auntie Rafiki inachuka jukumu la kushauli juu ya afya ya mama na mtoto";
  @override
  String get labelSecurity => "Ulinzi";
  @override
  String get labelSecurityInfo =>
      "Auntie Rafiki ina hakikisha faragha ya meseji na taarifa zako";

//Terms and conditions
  @override
  String get labelTermsAgreeInfo => "Nakubaliana na\t";
  @override
  String get labelTermsPrivacyInfo => "Sera ya Faragha \t";
  @override
  String get labelTermsAndInfo => "na\t";
  @override
  String get labelTermsUseInfo => "Masharti ya matumizi.";

  //Declaration
  @override
  String get labelDeclarationOne =>
      "Ninakubaliana na usindikaji wa taarifa zangu binafsi za afya ili kunipa utumiaji bora wa programu ya Auntie Rafiki. Tazama zaidi katika yetu\t";
  @override
  String get labelDeclarationTwo =>
      "Ninakubali kwamba Auntie Rafiki inaweza kutumia\t";
  @override
  String get labelDeclarationThree => "taarifa zangu binafsi\t";
  @override
  String get labelDeclarationFour =>
      "(isipokuwa taarifa za afya) kunitumia bidhaa au huduma kupitia barua pepe, programu ya Auntie Rafiki au washirika wa uuzaji.";
  @override
  String get labelDisclaimer =>
      "*\tUnaweza kuondoa idhini yako wakati wowote kwa kuwasiliana nasi kwa\t";

//Buttons
  @override
  String get labelNextButton => "Endelea";
  @override
  String get labelGetStartedButton => "Anza Sasa";
  @override
  String get labelSelectAllButton => "Changua zote";
  @override
  String get labelClearButton => "Futa";
  @override
  String get labelResendButton => "Tuma";
  @override
  String get labelVerifyButton => "Hakiki";

  //titles..
  @override
  String get labelVerifyYourPhoneNumber => "Hakiki namba yako ya simu";
  @override
  String get labelConfirmationCode => "Nambari ya Uthibitisho ";
  @override
  String get labelEnterTheCodeSentTo => "Ingiza nambari iliyotumwa kwa\t";
  @override
  String get labelDidNotReceiveTheCode => "Hukupokea nambari hiyo?\t";
}
