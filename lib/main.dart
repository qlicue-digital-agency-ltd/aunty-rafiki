import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:aunty_rafiki/providers/auth_provider.dart';
import 'package:aunty_rafiki/providers/baby_bump_provider.dart';
import 'package:aunty_rafiki/providers/blood_level_provider.dart';
import 'package:aunty_rafiki/providers/chat_provider.dart';
import 'package:aunty_rafiki/providers/task_provider.dart';
import 'package:aunty_rafiki/providers/text_to_speech_provider.dart';
import 'package:aunty_rafiki/providers/timeline_provider.dart';
import 'package:aunty_rafiki/providers/tracker_provider.dart';
import 'package:aunty_rafiki/providers/user_provider.dart';
import 'package:aunty_rafiki/providers/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => UtilityProvider()),
    ChangeNotifierProvider(create: (_) => TextToSpeechProvider()),
    ChangeNotifierProvider(create: (_) => TaskProvider()),
    ChangeNotifierProvider(create: (_) => AppointmentProvider()),
    ChangeNotifierProvider(create: (_) => BloodLevelProvider()),
    ChangeNotifierProvider(create: (_) => TimelineProvider()),
    ChangeNotifierProvider(create: (_) => BabyBumpProvider()),
    ChangeNotifierProvider(create: (_) => TrackerProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: App()));
}
