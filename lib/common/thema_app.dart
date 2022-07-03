import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const Color titleActive = Color(0xff222222);
const Color body = Color(0xff333333);
const Color label = Color(0xff555555);
const Color placeholder = Color(0xff888888);
const Color line = Color(0xffDCDCDC);
const Color inputBacgroud = Color(0xffF0F0F0);
const Color greyScaleBackgroud = Color(0xffD9DBE9);
const Color offWhite = Color(0xffFCFCFC);
const Color whiteCard = Color(0xffffffff);
const Color backgroundWhite = Color(0xffF8F8F8);

const LinearGradient gradientAccent = LinearGradient(
    colors: [Color(0xff0000F6), Color(0xff9041FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);
const LinearGradient gradientButton = LinearGradient(
    colors: [Color(0xff0038F5), Color(0xff9F03FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

ThemeData thmeaSiang() {
  return ThemeData.light().copyWith(
    appBarTheme: _themaAppBar(),
    scaffoldBackgroundColor: backgroundWhite,
    textTheme: GoogleFonts.epilogueTextTheme(),
  );
}

AppBarTheme _themaAppBar() {
  return AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark),
      backgroundColor: offWhite,
      iconTheme: _themaIcon(),
      elevation: 1,
      titleTextStyle: const TextStyle(
          color: body, fontSize: 20, fontWeight: FontWeight.bold));
}

IconThemeData _themaIcon() {
  return const IconThemeData(color: body);
}
