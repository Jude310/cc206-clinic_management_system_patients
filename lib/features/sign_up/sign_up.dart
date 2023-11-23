// ignore_for_file: prefer_const_constructors

import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:flutter/material.dart';
import '../components/sign_up_form_input_widget.dart';

class SignUpApp extends StatelessWidget {
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
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(36.0),
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                children: const [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Let\'s get you set up!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SignUpForm()
                ],
              ),
            )),
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

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _suffixController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  String? _sexController = 'Male';

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(
                  width: ((constraints.maxWidth / 5) * 3) - 16.0,
                  child: SignUpFormInputWidget(
                    label: 'First Name',
                    controller: _firstNameController,
                  ),
                ),
                SizedBox(width: 9.0),
                Flexible(
                  child: SignUpFormInputWidget(
                    label: 'Middle Name',
                    controller: _middleNameController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(
                  width: ((constraints.maxWidth / 5) * 4) - 16.0,
                  child: SignUpFormInputWidget(
                    label: 'Last Name',
                    controller: _lastNameController,
                  ),
                ),
                SizedBox(width: 6.0),
                Flexible(
                  child: SignUpFormInputWidget(
                    label: 'Suffix',
                    controller: _suffixController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
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
                SizedBox(width: 6.0),
                Flexible(
                  child: SignUpDropDownFormField(
                    label: 'Sex',
                    onChanged: (value) => _sexController = value,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  onPressed: _logIn,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF43C6AC),
                      foregroundColor: Colors.black),
                  child: Text("Next")),
            ),
            SizedBox(height: 16.0),
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
    // Clean up the focus node when the Form is disposed.
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
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
            border: OutlineInputBorder(
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
            DropdownMenuItem(
              value: 'Others',
              child: Text('Others'),
            ),
          ],
          onChanged: (value) => widget.onChanged,
        ),
      ],
    );
  }
}
