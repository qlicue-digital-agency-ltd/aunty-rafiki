import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _sendingPhone = false;
  bool _sendingCode = false;
  bool _initialized, _error;
  String _verificationId;
  AuthProvider() {
    initializeFlutterFire();
  }

  void initializeFlutterFire() async {
    print('XXXXX: Initializing flutter');
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

  set setSendingPhone(bool val) {
    _sendingPhone = val;
    notifyListeners();
  }

  set setInitialized(bool val) {
    _initialized = val;
    notifyListeners();
  }

  set setSendingCode(bool val) {
    _sendingCode = val;
    notifyListeners();
  }

  //getters

  bool get sendingPhone => _sendingPhone;
  bool get sendingCode => _sendingCode;
  String get verificationId => _verificationId;
  bool get initialized => _initialized;
  bool get error => _error;

  ///sigin user....
  Future<void> signIn(verificationId, smsCode) async {
    //   _sendingCode = true;
    UserCredential credential = await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    ));

    if (credential.user != null) {
      print("Auth User Phone: " + credential.user.phoneNumber);

      ///nove to login page....
    }
  }

  ///code retrival timed out
  codeAutoRetrievalTimeout(String verificationId) {
    _sendingPhone = false;
    _sendingCode = false;
  }

  ///code sent
  codeSent(String verificationId, int forceResendingToken) {
    _sendingPhone = false;
    _verificationId = verificationId;
    //_pageContent = _enterCode();
  }

  verificationFailed(FirebaseAuthException exception) {
    _sendingPhone = false;
    _sendingCode = false;
    notifyListeners();
  }

  requestVerificationCode(
      {@required String phoneNumber,
      @required verificationCompleted,
      @required verificationFailed,
      @required code,
      @required codeAuto}) async {
    _sendingPhone = true;
    notifyListeners();
    FirebaseAuth.instance.verifyPhoneNumber(
        timeout: Duration(seconds: 90),
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: code,
        codeAutoRetrievalTimeout: codeAuto);
  }

  verificationCompleted(PhoneAuthCredential credential) {
    _sendingPhone = false;
    _sendingCode = false;
    notifyListeners();

    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((UserCredential userCredential) {
      print("User Phone: " + userCredential.user.phoneNumber);
      print('got to home page');
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }
}
