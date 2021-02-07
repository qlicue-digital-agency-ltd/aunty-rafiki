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
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:aunty_rafiki/models/user.dart' as customUser;
import 'package:path_provider/path_provider.dart' as path_provider;

class AuthProvider with ChangeNotifier {
  bool _isSendingPhone = false;
  bool _sendingCode = false;
  bool _isVerifyingCode = false;
  bool _initialized, _error;
  bool _isLoggedIn = false;
  bool _isCodeSent = false;
  String _verificationId;
  PhoneNumber _phoneNumber;

  ///current user profile..
  customUser.User _currentUser;

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

  ///current user profile getter..
  customUser.User get currentUser => _currentUser;
  AuthProvider() {
    initializeFlutterFire();

    if (FirebaseAuth.instance.currentUser != null) {
      getUserProfile();
    }
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
  bool get isVerifyingCode => _isVerifyingCode;
  String get verificationId => _verificationId;
  bool get initialized => _initialized;
  bool get error => _error;
  PhoneNumber get phoneNumber => _phoneNumber;
  bool get isLoggedIn => _isLoggedIn;
  bool get isCodeSent => _isCodeSent;

  ///sigin user....
  Future<UserCredential> signIn({@required smsCode}) async {
    _isVerifyingCode = true;
    notifyListeners();
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
    _isVerifyingCode = false;
    notifyListeners();
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

  saveUserToFirestore({@required UserCredential userCredential}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    final user = users.where(FieldPath.documentId,
        isEqualTo: "${FirebaseAuth.instance.currentUser.uid}");

    print('=====================================');
    await user.get().then((snap) {
      if (snap.docs.isEmpty) {
        users.doc(userCredential.user.uid).set({
          'uid': userCredential.user.uid,
          'displayName': userCredential.user.displayName,
          'photoURL': userCredential.user.photoURL,
          'nameInitials': '~ ${userCredential.user.displayName}',
          'phoneNumber': userCredential.user.phoneNumber,
          'groups': [],
          'pregnancyWeeks': 0,
          'hasProfile': false
        });
        print('Mojaaa');
      } else if (snap.docs.first.data()['hasProfile']) {
        print('Mbili');
      } else {
        print('Tatu');
      }
    });

    print('++++++++++++++++++++++++++++++++++++++');
  }

  void cleaeSelectedImage() {
    _paths = [];
    notifyListeners();
  }

  //upload profile photo...
  Future<void> _uploadProleImageTask(File uploadFile) async {
    if (uploadFile != null) {
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref('uploads/profile/' +
              FirebaseAuth.instance.currentUser.uid +
              '.png')
          .putFile(uploadFile);

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

        updateProfile(key: 'photoURL', data: photoURL);
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
    }
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

    if (_paths == null) {
      _paths = [];
    } else {}
    notifyListeners();
  }

  //update user name..
  Future<bool> updateUsername(
      {@required String displayName, @required bool hasProfile}) async {
    bool _error = false;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'displayName': displayName, 'hasProfile': hasProfile});
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

  Future<bool> updateYearOfBirth({@required int yearOfBirth}) async {
    bool _error = false;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(FirebaseAuth.instance.currentUser.uid).update({
        'yearOfBirth': yearOfBirth,
      });
    } catch (e) {
      _error = true;
    }
    return _error;
  }

  Future<bool> updateMotherhoodInfo(
      {@required int gravida,
      @required String miscarriage,
      @required int miscarriageWeeks,
      @required int numberOfDeliveries,
      @required int numberOfOperationDeliveries,
      @required int numberOfNormalDeliveries}) async {
    bool _error = false;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(FirebaseAuth.instance.currentUser.uid).update({
        'gravida': gravida,
        'miscarriage': miscarriage,
        'miscarriageWeeks': miscarriageWeeks,
        'numberOfDeliveries': numberOfDeliveries,
        'numberOfOperationDeliveries': numberOfOperationDeliveries,
        'numberOfNormalDeliveries': numberOfNormalDeliveries,
      });
    } catch (e) {
      _error = true;
    }
    return _error;
  }

  ////more func
  Future<bool> updateAdditionalInfo(
      {@required int haemoLevel,
      @required DateTime haemoLevelDate,
      @required String startedClinic,
      @required String onMedication,
      @required String takenTetanusVaccine,
      @required DateTime lastDateTetanusVaccine,
      @required DateTime nextDateTetanusVaccine}) async {
    bool _error = false;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(FirebaseAuth.instance.currentUser.uid).update({
        'haemoLevel': haemoLevel,
        'haemoLevelDate': haemoLevelDate,
        'startedClinic': startedClinic,
        'onMedication': onMedication,
        'takenTetanusVaccine': takenTetanusVaccine,
        'lastDateTetanusVaccine': lastDateTetanusVaccine,
        'nextDateTetanusVaccine': nextDateTetanusVaccine,
        'hasProfile': true
      });
    } catch (e) {
      _error = true;
    }
    return _error;
  }

  Future<bool> checkUserHasProfile() async {
    bool _hasProfile = false;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = users.where(FieldPath.documentId,
        isEqualTo: "${FirebaseAuth.instance.currentUser.uid}");

    await user.get().then((snap) {
      if (snap.docs.isEmpty) {
        _hasProfile = false;
        print('Mojaaa');
      } else if (snap.docs.first.data()['hasProfile']) {
        _hasProfile = true;
        print('Mbili');
      } else {
        _hasProfile = false;
        print('Tatu');
      }
    });

    return _hasProfile;
  }

  Future<void> getUserProfile() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = users.doc(FirebaseAuth.instance.currentUser.uid).get();
    await user.then((doc) {
      _currentUser = customUser.User.fromFirestore(doc);
    });

    notifyListeners();
  }

  updateProfile({@required String key, @required dynamic data}) async {
    await db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      key: data,
    });
    getUserProfile();
    //clear all selected files
    cleaeSelectedImage();
  }

  ///Compress a single file..
  Future<File> _compressAndGetFile(File file, String targetPath) async {
    int bytes = await file.length();
    print("bytes:=> $bytes");
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 0,
      rotate: 0,
    );

    _uploadProleImageTask(result);

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  //upload profile..
  saveProfileImage() async {
    print('may b...');
    final dir = await path_provider.getTemporaryDirectory();
    var targetPath =
        dir.absolute.path + "/temp" + DateTime.now().toString() + ".jpg";
    _compressAndGetFile(files[0], targetPath);
  }
}
