import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/localization/language/languages.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/views/components/onboarding/walk_through.dart';
import 'package:aunty_rafiki/views/components/onboarding/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndexPage;
  int pageLength;
  final controller = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    currentIndexPage = 0;
    pageLength = 6;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _configProvider = Provider.of<ConfigProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * .1),
          Container(
            height: 400,
            child: PageView(
              controller: controller,
              pageSnapping: true,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Welcome(),
                Walkthrougth(
                    icon: "assets/icons/tracker.png",
                    title: Languages.of(context).labelTracker,
                    textContent: Languages.of(context).labelTrackerInfo),
                Walkthrougth(
                  icon: "assets/icons/chat.png",
                  title: Languages.of(context).labelChat,
                  textContent: Languages.of(context).labelChatInfo,
                ),
                Walkthrougth(
                    icon: "assets/icons/baby.png",
                    title: Languages.of(context).labelHealth,
                    textContent: Languages.of(context).labelHealthInfo),
                Walkthrougth(
                    icon: "assets/icons/shield.png",
                    title: Languages.of(context).labelSecurity,
                    textContent: Languages.of(context).labelSecurityInfo),
                Walkthrougth(
                    icon: "assets/icons/cloud-network.png",
                    title: Languages.of(context).labelCloudBased,
                    textContent: Languages.of(context).labelCloudBasedInfo),
              ],
              onPageChanged: (value) {
                setState(() => currentIndexPage = value);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SmoothPageIndicator(
              controller: controller,
              count: pageLength,
              effect: WormEffect(
                  activeDotColor: Colors.pink,
                  dotHeight: 10.0,
                  dotWidth: 10.0)),
          SizedBox(
            height: 100,
          ),
          Container(
            // color: Colors.pink[400],
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
                currentIndexPage == 5
                    ? Languages.of(context).labelGetStartedButton
                    : Languages.of(context).labelNextButton,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
              onPressed: () {
                if (currentIndexPage == 4) {
                  _configProvider.setConfigurationStep = Configuration.Terms;

                  Navigator.pushNamed(context, termsConditionPage);
                } else {
                  controller.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear);
                }
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    ));
  }
}
