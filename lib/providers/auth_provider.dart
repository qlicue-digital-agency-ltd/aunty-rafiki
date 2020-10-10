import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

class AuthProvider with ChangeNotifier {
  bool _isSendingPhone = false;
  bool _sendingCode = false;
  bool _initialized, _error;
  bool _isLoggedIn = false;
  bool _isCodeSent = false;
  String _verificationId;
  PhoneNumber _phoneNumber;
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
    UserCredential credential = await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    ));

    if (credential.user != null) {
      print("Auth User Phone: " + credential.user.phoneNumber);
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

  _verificationCompleted(PhoneAuthCredential credential) {
    _isSendingPhone = false;
    _sendingCode = false;
    notifyListeners();

    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((UserCredential userCredential) {
      print("User Phone: " + userCredential.user.phoneNumber);
      print('got to home page');
      //logic to trigger chage in ui...
      _isLoggedIn = true;
      notifyListeners();
    });
  }
}
