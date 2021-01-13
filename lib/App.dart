import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/sample/pages/new_group_page.dart';
import 'package:aunty_rafiki/views/pages/add_appointment.dart';
import 'package:aunty_rafiki/views/pages/add_blood_level_page.dart';
import 'package:aunty_rafiki/views/pages/appointment_page.dart';
import 'package:aunty_rafiki/views/pages/baby_bump_page.dart';
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
import 'package:aunty_rafiki/views/pages/time_line_page.dart';
import 'package:aunty_rafiki/views/pages/to_do_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'views/pages/home_page.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            case ConnectionState.none:
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Aunty Rafiki',
                theme: ThemeData(
                    primarySwatch: Colors.pink,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    textTheme: GoogleFonts.poppinsTextTheme()),
                home: FirebaseAuth.instance.currentUser == null
                    ? LoginPage()
                    : HomePage(),
                // home: StartupPage(),
                routes: {
                  landingPage: (context) =>
                      FirebaseAuth.instance.currentUser == null
                          ? LoginPage()
                          : HomePage(),
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
                  babyBumpPage: (_) => BabyBumpPage(),
                  createProfilePage: (_) => StepsPage(),
                  termsConditionPage: (_) => TermsConditionPage(),
                  choicePage: (_) => ChoicePage(),
                  stepsPage: (_) => StepsPage(),
                  '/new': (_) => NewGroupPage(),
                },
                //initialRoute: '/',
              );
              break;

            case ConnectionState.waiting:
            case ConnectionState.active:
              return Container();
              break;
          }
          return Container();
        });
  }
}
