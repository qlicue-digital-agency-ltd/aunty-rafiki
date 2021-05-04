import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/config_provider.dart';

import 'package:aunty_rafiki/views/pages/add_appointment.dart';
import 'package:aunty_rafiki/views/pages/add_blood_level_page.dart';
import 'package:aunty_rafiki/views/pages/appointment_page.dart';
import 'package:aunty_rafiki/views/pages/baby_name_page.dart';
import 'package:aunty_rafiki/views/pages/blood_level_page.dart';
import 'package:aunty_rafiki/views/pages/chat_room_page.dart';
import 'package:aunty_rafiki/views/pages/config/choice_page.dart';
import 'package:aunty_rafiki/views/pages/config/steps_page.dart';
import 'package:aunty_rafiki/views/pages/config/terms_conditions.dart';
import 'package:aunty_rafiki/views/pages/confirm_code_page.dart';
import 'package:aunty_rafiki/views/pages/create_task_page.dart';
import 'package:aunty_rafiki/views/pages/daily_appointments.dart';
import 'package:aunty_rafiki/views/pages/edit_profile_page.dart';
import 'package:aunty_rafiki/views/pages/food_page.dart';
import 'package:aunty_rafiki/views/pages/group/create_group_page.dart';
import 'package:aunty_rafiki/views/pages/group/select_contact_page.dart';
import 'package:aunty_rafiki/views/pages/home_page.dart';
import 'package:aunty_rafiki/views/pages/hospital_bag_page.dart';
import 'package:aunty_rafiki/views/pages/login_page.dart';
import 'package:aunty_rafiki/views/pages/onboarding_page.dart';
import 'package:aunty_rafiki/views/pages/profile_page.dart';
import 'package:aunty_rafiki/views/pages/splash_screen_page.dart';
import 'package:aunty_rafiki/views/pages/time_line_page.dart';
import 'package:aunty_rafiki/views/pages/to_do_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/enums/enums.dart';
import 'localization/locale_constant.dart';
import 'localization/localizations_delegate.dart';
import 'views/pages/home_page.dart';

class App extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_AppState>();
    state.setLocale(newLocale);
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _configProvider = Provider.of<ConfigProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);

    Widget _getLandingPage(config) {
      switch (config) {
        case Configuration.Terms:
          return TermsConditionPage();
        case Configuration.SignUp:
           print('POOOOO');
          if (FirebaseAuth.instance.currentUser == null) return LoginPage();
          if (_authProvider.currentUser.hasProfile) return HomePage();
          return StepsPage();
        case Configuration.Profile:
        case Configuration.NameScreenStepDone:
        case Configuration.WeeksPregnancyScreenStepDone:
        case Configuration.YearOfBirthScreenStepDone:
        case Configuration.MotherhoodInfoScreenStepDone:
        case Configuration.MoreInfoScreenStepDone:
          return StepsPage();
        case Configuration.Done:
          if (FirebaseAuth.instance.currentUser == null) return LoginPage();
          return HomePage();
        default:
          return OnboardingPage();
      }
    }

    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Auntie Rafiki',
      locale: _locale,
      supportedLocales: [Locale('en', ''), Locale('sw', '')],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale?.languageCode == locale?.languageCode &&
              supportedLocale?.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales?.first;
      },
      theme: ThemeData(
          primarySwatch: Colors.pink,
          primaryColor: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme()),
      home: AnimatedSplashScreen(),
      routes: {
        landingPage: (_) =>
            _getLandingPage(_configProvider.currentConfigurationStep),
        onboardingPage: (_) => OnboardingPage(),
        homePage: (_) => HomePage(),
        chatRoomPage: (_) => ChatRoomPage(),
        appointmentPage: (_) => AppointmentPage(),
        addAppointmentPage: (_) => AddAppointmentPage(),
        addBloodLevelPage: (_) => AddBloodLevelPage(),
        dailyAppointmentsPage: (_) => DailyAppointment(),
        confirmationPage: (_) => ConfirmResetCodePage(),
        selectContactsPage: (_) => SelectContactPage(),
        createGroupPage: (_) => CreateGroupPage(),
        profilePage: (_) => ProfilePage(),
        editProfilePage: (_) => EditProfilePage(),
        bloodLevelPage: (_) => BloodLevelTimeline(),
        toDoListPage: (_) => ToDoListPage(),
        babyNamePage: (_) => BabyNamePage(),
        timeLinePage: (_) => TimeLinePage(),
        hospitalBagPage: (_) => HospitalBagPage(),
        foodPage: (_) => FoodPage(),
        createTaskPage: (_) => CreateTaskPage(),
        createProfilePage: (_) => StepsPage(),
        termsConditionPage: (_) => TermsConditionPage(),
        choicePage: (_) => ChoicePage(),
        stepsPage: (_) => StepsPage(),
      },
    );
  }
}
