import 'dart:developer' as developer;

class AccountUser {
  late final String id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String username;
  final bool employed = false;
  final String employeeTitle = 'Patient';
  final int phoneNumber;
  final String email;
  final DateTime accountCreationDate;

  AccountUser({
    this.id = '',
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.phoneNumber,
    required this.email,
    required this.accountCreationDate,
  });

  factory AccountUser.fromJson(Map<String, dynamic> json) {
    developer.log(json.toString(), name: 'AccountUser.fromJson');
    return AccountUser(
      id: json['_id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      middleName: json['middleName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      accountCreationDate: DateTime.parse(json['accountCreatedOn']),
    );
  }

  Map<String, dynamic> get toJson => {
        '_id': id,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'middleName': middleName,
        'phoneNumber': phoneNumber,
        'email': email,
        'accountCreatedOn': accountCreationDate.toIso8601String(),
      };
  // AccountUser updateUser(String newUserName) {
  //   return {
  //     '_id': id,
  //     'username': newUserName,
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'middleName': middleName,
  //     'phoneNumber': phoneNumber,
  //     'email': email,
  //     'accountCreatedOn': accountCreationDate.toIso8601String(),
  //   };
  // }

  String get fullName => '$firstName ${middleName[0]}. $lastName';
}

// {"_id":"656a3759c1bd5a1f42e1a44e","employeeTitle":"Employee","employed":false,"adminPermission":false,"firstName":"MamÑa"}