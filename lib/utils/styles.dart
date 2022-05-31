import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color(0xFFFF8500);
const Color kSecondaryColor = Color(0xFFECA540);
const Color kDarkBrown = Color(0xFF4B2710);
const Color kWhite = Colors.white;
const Color kGrey = Color(0xFFD4D4D4);
const Color kGreyTransparant = Color(0xFF878787);
const Color kOrange = Color(0xFFEF9F21);

BorderRadius kBorderRadius = BorderRadius.circular(10);

const double kMargin = 20.0;
const double kPadding = 10.0;

final TextTheme kTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(fontSize: 41, fontWeight: FontWeight.w700),
  headline2: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600),
  headline3: GoogleFonts.poppins(
      fontSize: 21, fontWeight: FontWeight.w600, color: kSecondaryColor),
  headline4: GoogleFonts.poppins(
      fontSize: 21, fontWeight: FontWeight.w700, color: kDarkBrown),
  headline5: GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w700, color: kDarkBrown),
  headline6: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w700, color: kWhite),
  subtitle1: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w600, color: kDarkBrown),
  subtitle2: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w500, color: kDarkBrown),
  bodyText1: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, color: kGreyTransparant),
  bodyText2: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w300, color: kDarkBrown),
  button: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
  caption: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, color: kDarkBrown),
  overline: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, color: kOrange),
);

final kTimePickerTheme = TimePickerThemeData(
  backgroundColor: kWhite,
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: kPrimaryColor, width: 1),
  ),
  dayPeriodColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? kSecondaryColor : kWhite),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: kPrimaryColor, width: 1),
  ),
  dayPeriodTextColor: kDarkBrown,
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: kPrimaryColor, width: 1),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? kSecondaryColor : kWhite),
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? kWhite : kSecondaryColor),
  dialHandColor: kDarkBrown,
  dialBackgroundColor: kSecondaryColor,
  hourMinuteTextStyle:
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  dayPeriodTextStyle:
      const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  helpTextStyle: const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: kDarkBrown),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? kWhite : kDarkBrown),
  entryModeIconColor: kPrimaryColor,
);

const kColorScheme = ColorScheme(
  primary: kPrimaryColor,
  primaryContainer: kPrimaryColor,
  secondary: kSecondaryColor,
  secondaryContainer: kSecondaryColor,
  surface: kDarkBrown,
  background: kWhite,
  error: Colors.red,
  onPrimary: kWhite,
  onSecondary: kDarkBrown,
  onSurface: kDarkBrown,
  onBackground: kWhite,
  onError: kWhite,
  brightness: Brightness.light,
);
