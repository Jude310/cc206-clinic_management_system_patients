import 'package:flutter/material.dart';

const textColor = Color(0xFF010709);
const backgroundColor = Color.fromARGB(255, 255, 255, 255);
const primaryColor = Color(0xFF971779);
const primaryFgColor = Color(0xFFe9f7fc);
const secondaryColor = Color(0xFFb4e5f4);
const secondaryFgColor = Color(0xFF010709);
const accentColor = Color(0xFF99bf1d);
const accentFgColor = Color(0xFF010709);

const colorScheme1 = ColorScheme(
  brightness: Brightness.light,
  background: backgroundColor,
  onBackground: textColor,
  primary: primaryColor,
  onPrimary: primaryFgColor,
  secondary: secondaryColor,
  onSecondary: secondaryFgColor,
  tertiary: accentColor,
  onTertiary: accentFgColor,
  surface: backgroundColor,
  onSurface: textColor,
  error: Brightness.light == Brightness.light
      ? Color(0xffB3261E)
      : Color(0xffF2B8B5),
  onError: Brightness.light == Brightness.light
      ? Color(0xffFFFFFF)
      : Color(0xff601410),
);


final darkTheme = ThemeData(colorScheme: colorScheme1, useMaterial3: true);
 
  

  
