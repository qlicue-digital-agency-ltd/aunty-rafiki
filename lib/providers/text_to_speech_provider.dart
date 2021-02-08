  // import 'dart:io';

  // import 'package:aunty_rafiki/constants/enums/enums.dart';
  // import 'package:flutter/material.dart';
  // import 'package:flutter_tts/flutter_tts.dart';

  // class TextToSpeechProvider with ChangeNotifier {
  //   //audio reader....
  //   FlutterTts flutterTts;
  //   dynamic _languages;
  //   String language;
  //   double volume = 0.5;
  //   double pitch = 1.0;
  //   double rate = 0.5;

  //   String _newVoiceText;

  //   TtsState ttsState = TtsState.stopped;

  //   get isPlaying => ttsState == TtsState.playing;

  //   get isStopped => ttsState == TtsState.stopped;

  //   get isPaused => ttsState == TtsState.paused;

  //   get isContinued => ttsState == TtsState.continued;

  //   TextToSpeechProvider() {
  //     _initTts();
  //   }

  //   _initTts() {
  //     flutterTts = FlutterTts();

  //     _getLanguages();

  //     if (Platform.isAndroid) {
  //       _getEngines();
  //     }

  //     flutterTts.setStartHandler(() {
  //       print("Playing");
  //       ttsState = TtsState.playing;
  //       notifyListeners();
  //     });

  //     flutterTts.setCompletionHandler(() {
  //       print("Complete");
  //       ttsState = TtsState.stopped;
  //       notifyListeners();
  //     });

  //     flutterTts.setCancelHandler(() {
  //       print("Cancel");
  //       ttsState = TtsState.stopped;
  //       notifyListeners();
  //     });

  //     if (Platform.isIOS) {
  //       flutterTts.setPauseHandler(() {
  //         print("Paused");
  //         ttsState = TtsState.paused;
  //         notifyListeners();
  //       });

  //       flutterTts.setContinueHandler(() {
  //         print("Continued");
  //         ttsState = TtsState.continued;
  //         notifyListeners();
  //       });
  //     }

  //     flutterTts.setErrorHandler((msg) {
  //       print("error: $msg");
  //       ttsState = TtsState.stopped;
  //       notifyListeners();
  //     });
  //   }

  //   set setLanguage(String lang) {
  //     flutterTts.setLanguage(lang);
  //     notifyListeners();
  //   }

  //   Future _getLanguages() async {
  //     _languages = await flutterTts.getLanguages;
  //     if (_languages != null) return _languages;
  //   }

  //   Future _getEngines() async {
  //     var engines = await flutterTts.getEngines;
  //     if (engines != null) {
  //       for (dynamic engine in engines) {
  //         print(engine);
  //       }
  //     }
  //   }

  //   Future speak() async {
  //     await flutterTts.setVolume(volume);
  //     await flutterTts.setSpeechRate(rate);
  //     await flutterTts.setPitch(pitch);

  //     if (_newVoiceText != null) {
  //       if (_newVoiceText.isNotEmpty) {
  //         await flutterTts.awaitSpeakCompletion(true);
  //         await flutterTts.speak(_newVoiceText);
  //       }
  //     }
  //   }

  //   Future stop() async {
  //     var result = await flutterTts.stop();
  //     if (result == 1) ttsState = TtsState.stopped;
  //     notifyListeners();
  //   }

  //   Future pause() async {
  //     var result = await flutterTts.pause();
  //     if (result == 1) ttsState = TtsState.paused;
  //     notifyListeners();
  //   // }

  //   //getter
  //   dynamic get getLanguages => _languages;
  // }
