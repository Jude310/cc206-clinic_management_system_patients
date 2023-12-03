import 'dart:convert';

import 'package:cc206_clinic_management_website_patients/features/log_in/log_in_page.dart';
import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/sign_up_form_input_widget.dart';


class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/LoginSignUp_BG.png',
              fit: BoxFit.cover,
            )),
        Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: const Text(
              'Sign Up',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(36.0, 0, 36.0, 36.0),
              child: Center(
                child: Column(
                  children: [
                    // SvgPicture.asset(
                    //   'logo/logo_1.svg',
                    //   width: 150,
                    // ),

                    SignUpForm()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  void _logIn() {}
  void _signUp() {}
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _suffixController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _sexController = 'Male';

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      setState(() {
        _birthdateController.text = selectedDate.toString().split(" ")[0];
      });
    }
  }

  Future<void> _sendSignUpForm() async {
    final Map<String, dynamic> signUpInformation = {
      'username': _usernameController.text,
      'password': _passwordController.text,
      'employeeTitle': 'Patient',
      'firstName': _firstNameController.text,
      'middleName': _middleNameController.text,
      'lastName': _lastNameController.text,
      'phoneNumber': _phoneController.text,
      'email': _emailController.text,
      'sex': _sexController
    };

    final String signUpJson = jsonEncode(signUpInformation);

    try {
      final http.Response response =
          await http.post(Uri.https('clinic-man.onrender.com', 'signup'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: signUpJson);
      if (response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Signup Successful"),
                content: const Text(
                    'Your account has been created successfully! Returning to Log In'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Signup Failed"),
                content: Text(
                    'Request failed. Code: ${response.statusCode}\nBody: ${response.body}\n Returning to Log In.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Signup Failed"),
              content: const Text('Failed to post signup. Returning to Log In'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16.0),
            const Text('Personal Information',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black)),
            const Divider(),
            Row(
              children: [
                SizedBox(
                  width: ((constraints.maxWidth / 5) * 3) - 16.0,
                  child: SignUpFormInputWidget(
                    label: 'First Name',
                    controller: _firstNameController,
                  ),
                ),
                const SizedBox(width: 9.0),
                Flexible(
                  child: SignUpFormInputWidget(
                    label: 'Middle Name',
                    controller: _middleNameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(
                  width: ((constraints.maxWidth / 5) * 4) - 16.0,
                  child: SignUpFormInputWidget(
                    label: 'Last Name',
                    controller: _lastNameController,
                  ),
                ),
                const SizedBox(width: 6.0),
                Flexible(
                  child: SignUpFormInputWidget(
                    label: 'Suffix',
                    controller: _suffixController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                SizedBox(
                  width: ((constraints.maxWidth / 5) * 3.5) - 16.0,
                  child: SignUpFormInputWidget(
                    label: 'Birthdate',
                    controller: _birthdateController,
                    readOnly: true,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _selectDate();
                    },
                  ),
                ),
                const SizedBox(width: 6.0),
                Flexible(
                  child: SignUpDropDownFormField(
                    label: 'Sex',
                    onChanged: (value) => _sexController = value!,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text('Contact Information',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black)),
            const Divider(),
            SizedBox(
              width: constraints.maxWidth,
              child: SignUpFormInputWidget(
                label: 'Phone Number',
                controller: _phoneController,
              ),
            ),
            const SizedBox(height: 5.0),
            // SizedBox(
            //   width: constraints.maxWidth,
            //   child: SignUpFormInputWidget(
            //     label: 'Address',
            //     controller: _addressController,
            //   ),
            // ),
            // const SizedBox(height: 16.0),
            const Text('Account Information',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black)),
            const Divider(),
            SizedBox(
              width: constraints.maxWidth,
              child: SignUpFormInputWidget(
                label: 'Email',
                controller: _emailController,
              ),
            ),
            const SizedBox(height: 5.0),
            SizedBox(
              width: constraints.maxWidth,
              child: SignUpFormInputWidget(
                label: 'Username',
                controller: _usernameController,
              ),
            ),
            const SizedBox(height: 5.0),
            SizedBox(
              width: constraints.maxWidth,
              child: SignUpFormInputWidget(
                label: 'Password',
                controller: _passwordController,
              ),
            ),
            const SizedBox(height: 5.0),
            SizedBox(
              width: constraints.maxWidth,
              child: SignUpFormInputWidget(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  await _sendSignUpForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43C6AC),
                  foregroundColor: Colors.black,
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
          ],
        ),
      );
    });
  }
}

class SignUpDropDownFormField extends StatefulWidget {
  final String label;
  final void Function(String?)? onChanged;
  const SignUpDropDownFormField(
      {this.label = '', required this.onChanged, super.key});

  @override
  State<SignUpDropDownFormField> createState() =>
      _SignUpDropDownFormFieldState();
}

class _SignUpDropDownFormFieldState extends State<SignUpDropDownFormField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          textAlign: TextAlign.start,
          style: TextStyle(
            color:
                !_hasFocus ? colorScheme1.onBackground : colorScheme1.primary,
            fontSize: 14.0,
            fontWeight: !_hasFocus ? FontWeight.w500 : FontWeight.w600,
          ),
          overflow: TextOverflow.fade,
        ),
        DropdownButtonFormField(
          isExpanded: true,
          elevation: 6,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.95),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'Male',
              child: Text('Male'),
            ),
            DropdownMenuItem(
              value: 'Female',
              child: Text('Female'),
            ),
          ],
          onChanged: (value) => widget.onChanged,
        ),
      ],
    );
  }
}
