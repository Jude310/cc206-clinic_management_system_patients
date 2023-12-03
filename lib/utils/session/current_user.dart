import 'dart:convert';
import 'package:cc206_clinic_management_website_patients/models/patient_model.dart';
import 'package:cc206_clinic_management_website_patients/models/user_model.dart';
import 'package:cc206_clinic_management_website_patients/utils/session/sessions.dart';

class CurrentUser {
  static AccountUser? _currentUser;
  static Patient? _currentPatient;
  static bool _loggedIn = false;
  // static late AccountUser _currentAccount;
  static AccountUser? get currentUser => _currentUser;
  static Patient? get patient => _currentPatient;

  static bool get isloggedIn => _loggedIn;
  static _clearCurrentUser() {
    _currentUser = null;
    _loggedIn = false;
  }


  static Future logOut(
      {void Function()? onSuccess, void Function()? onFail}) async {
    final response = await Session.post('/logout');

    if (response.statusCode == 201) {
      Session.clearSession();
      CurrentUser._clearCurrentUser();
      //clear AccountUser
      print(response.statusCode);
      print(response.body);
      onSuccess?.call();
    } else {
      print(response.statusCode);
      print(response.body);
      onFail?.call();
    }
  }

  static Future<void> logIn(
      {required username,
      required password,
      void Function()? onSuccess,
      void Function()? onFail}) async {
    final userData = {'username': username, 'password': password};

    final response = await Session.post(
      '/',
      body: userData,
    );

    if (response.statusCode == 201) {
      //get patient ID then store to session
      AccountUser user = await _getAccountProfile(await _getAccountId());
      await _saveAccount(user);
      _loggedIn = true;
      onSuccess?.call();
    } else {
      //TODO: Add error handling
      print(response.statusCode);
      print(response.body);
      onFail?.call();
    }
  }

  static Future<String> _getAccountId() async {
    var response = await Session.get('/testing123');
    var user = jsonDecode(response.body);

    return user._id;
  }

  static Future _getAccountProfile(String id) async {
    var response = await Session.get('/user/$id');
    var userProfile = AccountUser.fromJson(jsonDecode(response.body));

    return userProfile;
  }

  static Future<Patient?> _getPatient() async {
    var response = await Session.get('patients/patientFromUser');
    if (response.message == 'Not Found') {
      return null;
    }
    var patientData = jsonDecode(response.body)['somePatient'][0];
    var patient = Patient.fromJson(patientData);
    return patient;
  }

  static Future<void> _saveAccount(AccountUser user) async {
    _currentUser = user;
    _currentPatient = await _getPatient();
  }
}
