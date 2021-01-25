import 'dart:io';

import 'package:aunty_rafiki/constants/enums/enums.dart';
import 'package:aunty_rafiki/service/shared/shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class AuthProvider with ChangeNotifier {
  bool _isSendingPhone = false;
  bool _sendingCode = false;
  bool _initialized, _error;
  bool _isLoggedIn = false;
  bool _isCodeSent = false;
  String _verificationId;
  PhoneNumber _phoneNumber;

  /// Shared preference DB
  SharedPref _sharedPref = SharedPref();

  //app configuration...
  Configuration _appConfigurationStep = Configuration.Non;

  ///setter for configuration
  set setConfigurationStep(Configuration step) {
    _appConfigurationStep = step;

    String _result = EnumToString.convertToString(_appConfigurationStep);

    _sharedPref.saveStringleString('configurationStep', _result);

    notifyListeners();
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<PlatformFile> _paths = [];
  bool _loadingPath = false;

  List<File> get files => _paths.map((path) => File(path.path)).toList();
  bool get loadingPath => _loadingPath;

  AuthProvider() {
    initializeFlutterFire();
  }

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();

      _initialized = true;
      notifyListeners();
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print('Error in initializing app ${e.toString()}');
      _error = true;
      notifyListeners();
    }
  }

  //setters

  set setPhoneNumber(PhoneNumber phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  set setInitialized(bool val) {
    _initialized = val;
    notifyListeners();
  }

  //getters

  bool get isSendingPhone => _isSendingPhone;
  bool get isSendingCode => _sendingCode;
  String get verificationId => _verificationId;
  bool get initialized => _initialized;
  bool get error => _error;
  PhoneNumber get phoneNumber => _phoneNumber;
  bool get isLoggedIn => _isLoggedIn;
  bool get isCodeSent => _isCodeSent;

  ///sigin user....
  Future<UserCredential> signIn({@required smsCode}) async {
    //   _sendingCode = true;
    UserCredential credential;

    try {
      credential = await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      ));

      if (credential.user != null) {
        print("Auth User Phone: " + credential.user.phoneNumber);
        saveUserToFirestore(userCredential: credential);
      }
    } catch (e) {
      authProblems errorType;
      if (Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = authProblems.NetworkError;
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      } else if (Platform.isIOS) {
        switch (e.code) {
          case 'Error 17011':
            errorType = authProblems.UserNotFound;
            break;
          case 'Error 17009':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'Error 17020':
            errorType = authProblems.NetworkError;
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      }
      print('The error is $errorType');
    }
    return credential;
  }

  //sigin out user
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  ///code retrival timed out
  _codeAutoRetrievalTimeout(String verificationId) {
    _isSendingPhone = false;
    _sendingCode = false;
    notifyListeners();
  }

  ///code sent
  _codeSent(String verificationId, int forceResendingToken) {
    _isSendingPhone = false;
    _isCodeSent = true;
    _verificationId = verificationId;
    notifyListeners();
    //write the logic to switch ui to go to code verification page
    //_pageContent = _enterCode();
  }

  _verificationFailed(FirebaseAuthException exception) {
    _isSendingPhone = false;
    _sendingCode = false;

    notifyListeners();
  }

  Future<void> requestVerificationCode() async {
    _isSendingPhone = true;

    notifyListeners();
    String _phone = _phoneNumber.completeNumber.replaceAll('(', "");
    _phone = _phone.replaceAll(')', '');
    _phone = _phone.replaceAll('-', '');
    _phone = _phone.replaceAll(' ', '');

    print(_phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: 90),
        phoneNumber: _phone,
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  _verificationCompleted(PhoneAuthCredential credential) async {
    _isSendingPhone = false;
    _sendingCode = false;
    notifyListeners();
    _isLoggedIn = true;
    notifyListeners();
  }

  saveUserToFirestore({@required UserCredential userCredential}) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.doc(userCredential.user.uid).set({
      'uid': userCredential.user.uid,
      'displayName': userCredential.user.displayName,
      'photoURL': userCredential.user.photoURL,
      'nameInitials': '~Xcode',
      'phoneNumber': userCredential.user.phoneNumber,
      'groups': [],
      'pregnancyWeeks': 0
    });
  }

  void resetImage() {
    _paths = null;
    notifyListeners();
  }

  //upload profile photo...
  Future<void> updateProfileTask(
      {String displayName, String nameInitials}) async {
    if (files.isNotEmpty) {
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref('uploads/profile/' +
              FirebaseAuth.instance.currentUser.uid +
              '.png')
          .putFile(files[0]);

      task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
        print('Task state: ${snapshot.state}');
        print(
            'Progress: ${(snapshot.totalBytes / snapshot.bytesTransferred) * 100} %');
      }, onError: (e) {
        // The final snapshot is also available on the task via `.snapshot`,
        // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
        //print(task.snapshot);
        print('User does not have ');
        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
        }
      });
      try {
        // Storage tasks function as a Delegating Future so we can await them.
        final url = await task;

        String photoURL = await url.ref.getDownloadURL();
        //update profile...
        _updateProfile(
            photoURL: photoURL,
            displayName: displayName,
            nameInitials: nameInitials);
        print('Upload complete.' + photoURL);
      } on firebase_core.FirebaseException catch (e) {
        // The final snapshot is also available on the task via `.snapshot`,
        // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
        print(task.snapshot);

        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
        }
        // ...
      }
    } else {
      _updateProfile(displayName: displayName, nameInitials: nameInitials);
    }
  }

//upload file url......
  _updateProfile({String displayName, String nameInitials, String photoURL}) {
    db.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
      'photoURL': photoURL,
      'displayName': displayName,
      'nameInitials': nameInitials,
    });
  }

  ///getter for configuration ...
  Future<Configuration> get appConfigurationStep async {
    final _config = await _sharedPref.readStringleString('configurationStep');
    print(_config);
    if (_config != null) {
      _appConfigurationStep =
          EnumToString.fromString(Configuration.values, _config);
    }
    return _appConfigurationStep;
  }

  Future<void> openFileExplorer() async {
    _loadingPath = true;
    notifyListeners();

    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        allowedExtensions: null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    notifyListeners();
  }

  //update user name..
  Future<bool> updateUsername({@required String displayName}) async {
    bool _error = false;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(FirebaseAuth.instance.currentUser.uid).update({
        'displayName': displayName,
      });
    } catch (e) {
      _error = true;
    }
    return _error;
  }

  Future<bool> updatePregnancyWeeks({@required int pregnancyWeeks}) async {
    bool _error = false;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(FirebaseAuth.instance.currentUser.uid).update({
        'pregnancyWeeks': pregnancyWeeks,
      });
    } catch (e) {
      _error = true;
    }
    return _error;
  }
}
