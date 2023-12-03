import 'dart:convert';
import 'package:cc206_clinic_management_website_patients/models/patient_model.dart';
import 'package:cc206_clinic_management_website_patients/models/user_model.dart';
import 'package:cc206_clinic_management_website_patients/utils/session/sessions.dart';
import 'dart:developer' as developer;
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
    var userData = {'username': username, 'password': password};

    var response = await Session.post(
      '/',
      body: userData,
    );

      print('hi');
    if (response.statusCode == 201) {
      //get patient ID then store to session
      AccountUser user = await _getAccountProfile(await _getAccountId());
      // print(response.body);
      await _saveAccount(user);
      _loggedIn = true;
      // print(CurrentUser._currentPatient);
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
    // developer.log('response.body: ${response.body}');
    var user = jsonDecode(response.body);
 
    // developer.log('user: $user');
    // developer.log('getaccountId: ${user['_id']}');
    return '${user['_id']}';
  }

  static Future _getAccountProfile(String id) async {
    developer.log( 'id: $id', name: 'account profile');
    var response = await Session.get('/users/$id');
    developer.log('account profile body: ${response.body}');
    var userProfile = AccountUser.fromJson(jsonDecode(response.body));

    return userProfile;
  }

  static Future<Patient?> _getPatient() async {
    var response = await Session.get('patients/patientFromUser');
    developer.log('${response.body}', name: 'get_patient_api');
    // if (response. == 'Not Found') {
    //   return null;
    // }
    var patientData = jsonDecode(response.body)['somePatient'][0];
    var patient = Patient.fromJson(patientData);
    return patient;
  }

  static Future<void> _saveAccount(AccountUser user) async {
    _currentUser = user;
    _currentPatient = await _getPatient();
  }
}
