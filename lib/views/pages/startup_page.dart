import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';
import 'package:aunty_rafiki/views/pages/config/terms_conditions.dart';
import 'package:aunty_rafiki/views/pages/home_page.dart';
import 'package:aunty_rafiki/views/pages/loader_page.dart';
import 'package:aunty_rafiki/views/pages/login_page.dart';
import 'package:aunty_rafiki/views/pages/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/steps_page.dart';

class StartupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _configProvider = Provider.of<ConfigProvider>(context);

    return FutureBuilder(
        future: _configProvider.appConfigurationStep,
        builder: (context, AsyncSnapshot<Configuration> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            case ConnectionState.none:
              switch (snapshot.data) {
                case Configuration.Non:
                  return OnboardingPage();
                  break;
                case Configuration.Terms:
                  return TermsConditionPage();
                  break;
                case Configuration.SignUp:
                  return LoginPage();
                  break;
                case Configuration.Profile:
                  return StepsPage();
                  break;
                case Configuration.Done:
                  return FirebaseAuth.instance.currentUser == null
                      ? LoginPage()
                      : HomePage();
                  break;
                default:
                  return StepsPage();
              }

          

              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return LoaderPage();

              break;
          }
          return Container();
        });
  }
}
