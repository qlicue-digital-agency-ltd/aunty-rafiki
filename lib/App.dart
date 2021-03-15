import 'package:aunty_rafiki/constants/routes/routes.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants/enums/enums.dart';
import 'views/pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _configProvider = Provider.of<ConfigProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aunty Rafiki',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme()),
      home: AnimatedSplashScreen(),
      routes: {
        landingPage: (_) => _configProvider.currentConfigurationStep ==
                Configuration.Terms
            ? TermsConditionPage()
            : _configProvider.currentConfigurationStep == Configuration.SignUp
                ? LoginPage()
                : (_configProvider.currentConfigurationStep ==
                        Configuration.Profile
                    ? StepsPage()
                    : _configProvider.currentConfigurationStep ==
                            Configuration.NameScreenStepDone
                        ? StepsPage()
                        : _configProvider.currentConfigurationStep ==
                                Configuration.WeeksPregnancyScreenStepDone
                            ? StepsPage()
                            : _configProvider.currentConfigurationStep ==
                                    Configuration.YearOfBirthScreenStepDone
                                ? StepsPage()
                                : _configProvider.currentConfigurationStep ==
                                        Configuration
                                            .MotherhoodInfoScreenStepDone
                                    ? StepsPage()
                                    : _configProvider
                                                .currentConfigurationStep ==
                                            Configuration.MoreInfoScreenStepDone
                                        ? StepsPage()
                                        : _configProvider
                                                    .currentConfigurationStep ==
                                                Configuration.Done
                                            ? (FirebaseAuth
                                                        .instance.currentUser ==
                                                    null
                                                ? LoginPage()
                                                : HomePage())
                                            : OnboardingPage()),
        onboardingPage: (_) => OnboardingPage(),
        loginPage: (_) => LoginPage(),
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
