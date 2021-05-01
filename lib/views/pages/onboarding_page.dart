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
                Walkthrougth(
                    icon: "assets/icons/tracker.png",
                    title: "Tracker",
                    textContent:
                        "Auntie Rafiki tunafatilia ukuwaji wa kila siku wa ujauzito wako."),
                Walkthrougth(
                  icon: "assets/icons/chat.png",
                  title: 'Chati',
                  textContent:
                      "Auntie Rafiki ina kuunganisha na mkunga wa kukusaidia masaa 24 kila siku.",
                ),
                Walkthrougth(
                    icon: "assets/icons/baby.png",
                    title: 'Afya',
                    textContent:
                        "Auntie Rafiki inachuka jukumu la kushauli juu ya afya ya mama na mtoto."),
                Walkthrougth(
                    icon: "assets/icons/shield.png",
                    title: 'Ulinzi',
                    textContent:
                        "Auntie Rafiki ina hakikisha faragha ya meseji na taarifa zako."),
                Walkthrougth(
                    icon: "assets/icons/cloud-network.png",
                    title: 'Cloud-Based',
                    textContent:
                        "Auntie Rafiki ina kuruhusu kupata taarifa zako kwa kutumia vifaa tofauti vya tehama."),
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
                currentIndexPage == 4 ? "Get Start" : "Next",
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
