import 'package:cc206_clinic_management_website_patients/pages/dashboard.dart';
import 'package:cc206_clinic_management_website_patients/features/sign_up/sign_up.dart';
import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:cc206_clinic_management_website_patients/utils/session/sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final logInFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool logInError = false;
  // String url = 'clinic-man.onrender.com';

  // Future _logIn(context) async {
  //   var userData = {
  //     'username': _emailController.text,
  //     'password': _passwordController.text,
  //   };
  //   print(userData);
  //   var response = await Session.post(
  //     'https://clinic-man.onrender.com',
  //     body: userData,
  //   );

  //   if (response.statusCode == 201) {
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => DashBoard()));
  //   } else {
  //     setState(() {
  //       logInError = true;
  //     });
  //   }
  // }

  Future getTest() async {
    try {
      final response = await Session.get('/');
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future _logIn(context) async {
    setState(() {
      logInError = false;
    });
    var userData = {
      'username': _emailController.text,
      'password': _passwordController.text
    };

    final response = await Session.post(
      '/',
      body: userData,
    );

    if (response.statusCode == 201) {
//get patient ID then store to session
      
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DashBoard()));
    } else {
      setState(() {
        logInError = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromARGB(255, 245, 244, 243),
            child: Opacity(
              opacity: 0.90,
              child: Image.asset(
                'assets/images/LoginSignUp_BG.png',
                fit: BoxFit.cover,
              ),
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      'assets/logo/Farmacia 3.svg',
                      width: 150,
                    ),
                    const Text(
                      'Farmacia Hinosa',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 10.0),
                Form(
                  key: logInFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16.0, right: 10.0),
                            child: Icon(Icons.account_circle,
                                color: colorScheme1.primary),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Icon(Icons.vpn_key,
                                color: colorScheme1.primary),
                          ),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10.0,
                        child:
                            Text(logInError ? 'Invalid Email or Password' : ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 95.0),
                        child: ElevatedButton(
                          onPressed: () => _logIn(context),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                colorScheme1.tertiary),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: accentFgColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      //make a hyperlink text

                      TextButton(
                        onPressed: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUp()))
                        },
                        child: const Text(
                          'No account? Cick here to Sign up',
                          style: TextStyle(
                            fontSize: 12.0,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
