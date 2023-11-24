import 'package:cc206_clinic_management_website_patients/features/sign_up/sign_up.dart';
import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  final logInFormKey = GlobalKey<FormState>();

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
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
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
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 95.0),
                        child: ElevatedButton(
                          onPressed: () {},
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

                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignUp()), // Replace with your SignUp widget
                          )
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
