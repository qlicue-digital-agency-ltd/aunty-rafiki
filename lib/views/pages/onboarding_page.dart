import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/views/components/onboarding/walk_through.dart';
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
    pageLength = 5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final _confogProvider = Provider.of<ConfigProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 500,
            child: PageView(
              controller: controller,
              pageSnapping: true,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Walkthrougth(
                    icon: "assets/icons/fast-time.png",
                    title: "Tracker",
                    textContent:
                        "Aunty Rafiki tracks your daily pregancy growth and changes."),
                Walkthrougth(
                  icon: "assets/icons/chat.png",
                  title: 'Chat',
                  textContent:
                      "Aunty Rafiki is connects you to your favorite midwife, 24/7",
                ),
                Walkthrougth(
                    icon: "assets/icons/baby.png",
                    title: 'Health',
                    textContent:
                        "Aunty Rafiki carters for the health condition for you and your baby"),
                Walkthrougth(
                    icon: "assets/icons/shield.png",
                    title: 'Secure',
                    textContent:
                        "Aunty Rafiki keeps your information and messages safe from hacker attacks"),
                Walkthrougth(
                    icon: "assets/icons/cloud-network.png",
                    title: 'Cloud-Based',
                    textContent:
                        "Aunty Rafiki lets you access your messages from multiple devices"),
              ],
              onPageChanged: (value) {
                setState(() => currentIndexPage = value);
              },
            ),
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
            margin: EdgeInsets.only(left: 60, right: 60),
            width: double.infinity / 2,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.pink[400],
              child: Text(
                currentIndexPage == 4 ? "Get Start" : "Next",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
              onPressed: () {
                if (currentIndexPage == 4) {
                  _confogProvider.setConfigurationStep = Configuration.Terms;
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
            height: 200,
          ),
        ],
      ),
    ));
  }
}
