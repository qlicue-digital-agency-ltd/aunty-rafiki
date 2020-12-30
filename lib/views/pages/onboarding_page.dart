import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/views/components/onboarding/walk_through.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageView(
          controller: controller,
          pageSnapping: true,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Walkthrougth(
                icon: "assets/icons/fast-time.png",
                title: "Fast",
                textContent:
                    "Aunty Rafiki delivers information faster than any other application"),
            Walkthrougth(
              icon: "assets/icons/free.png",
              title: 'Free',
              textContent:
                  "Aunty Rafiki is forever free, No ads NO subscription fee",
            ),
            Walkthrougth(
                icon: "assets/icons/thunderbolt.png",
                title: 'Powerful',
                textContent:
                    "Aunty Rafiki has no limit to the size of your media chat"),
            Walkthrougth(
                icon: "assets/icons/shield.png",
                title: 'Secure',
                textContent:
                    "Aunty Rafiki keeps your messages safe from hacker attacks"),
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
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 100,
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
                    "Get Start",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, landingPage);
                  },
                ),
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
