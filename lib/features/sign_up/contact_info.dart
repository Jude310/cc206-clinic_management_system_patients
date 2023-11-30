import 'package:cc206_clinic_management_website_patients/features/components/sign_up_form_input_widget.dart';
import 'package:flutter/material.dart';

class SignUpContactInfoPage extends StatefulWidget {
  const SignUpContactInfoPage({super.key});

  @override
  State<SignUpContactInfoPage> createState() => SignUp_ContactInfoPageState();
}

class SignUp_ContactInfoPageState extends State<SignUpContactInfoPage> {
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
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Let\'s get you set up!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  ContactInfoForm(),
                ],
              ),
            )),
          ),
        ),
      ],
    );
  }
}

class ContactInfoForm extends StatefulWidget {
  const ContactInfoForm({super.key});

  @override
  State<ContactInfoForm> createState() => _ContactInfoFormState();
}

class _ContactInfoFormState extends State<ContactInfoForm> {
TextEditingController _emailController = TextEditingController(); 
TextEditingController _addressController = TextEditingController(); 
TextEditingController _phoneController = TextEditingController(); 
TextEditingController _cityController = TextEditingController(); 
TextEditingController _provinceController = TextEditingController(); 
TextEditingController _zipCodeController = TextEditingController(); 
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16.0),
                SizedBox(
                  width: ((constraints.maxWidth / 5) * 3) - 16.0,
                  child: SignUpFormInputWidget(
                    label: 'Email',
                    controller: _emailController,
                  ),
                ),
           
            SizedBox(height: 8.0),
            SizedBox(
              width: ((constraints.maxWidth / 5) * 4) - 16.0,
              child: SignUpFormInputWidget(
                label: 'Last Name',
                controller: _addressController,
              ),
            ),
            
            // SizedBox(height: 10.0),
            // Row(  
            //   children: [
            //     SizedBox(
            //       width: ((constraints.maxWidth / 5) * 3.5) - 16.0,
            //       child: SignUpFormInputWidget(
            //         label: 'Birthdate',
            //         controller: _addressController,
            //         readOnly: true,
            //         onTap: () {
            //           FocusScope.of(context).requestFocus(FocusNode());
            //           _selectDate();
            //         },
            //       ),
            //     ),
            //     SizedBox(width: 6.0),
            //     Flexible(
            //       child: SignUpDropDownFormField(
            //         label: 'Sex',
            //         onChanged: (value) => _sexController = value,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  onPressed: ()=> {},
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
