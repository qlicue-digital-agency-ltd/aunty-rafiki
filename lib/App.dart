import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/views/pages/add_appointment.dart';
import 'package:aunty_rafiki/views/pages/appointment_page.dart';
import 'package:aunty_rafiki/views/pages/chat_room_page.dart';
import 'package:aunty_rafiki/views/pages/confirm_code_page.dart';
import 'package:aunty_rafiki/views/pages/daily_appointments.dart';
import 'package:aunty_rafiki/views/pages/edit_profile_page.dart';
import 'package:aunty_rafiki/views/pages/group/create_group_page.dart';
import 'package:aunty_rafiki/views/pages/group/select_contact_page.dart';
import 'package:aunty_rafiki/views/pages/home_page.dart';
import 'package:aunty_rafiki/views/pages/login_page.dart';
import 'package:aunty_rafiki/views/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.pink,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: FirebaseAuth.instance.currentUser == null
                    ? LoginPage()
                    : HomePage(),
                routes: {
                  homePage: (_) => HomePage(),
                  chatRoomPage: (_) => ChatRoomPage(),
                  appointmentPage: (_) => AppointmentPage(),
                  addAppointmentPage: (_) => AddAppointmentPage(),
                  dailyAppointmentsPage: (_) => DailyAppointment(),
                  confirmationPage: (_) => ConfirmResetCodePage(),
                  selectContactsPage: (_) => SelectContactPage(),
                  createGroupPage: (_) => CreateGroupPage(),
                  profilePage: (_) => ProfilePage(),
                  editProfilePage: (_) => EditProfilePage(),
                },
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
