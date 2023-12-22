import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_colors.dart';


ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: MyColors.lightThemeColor,
    scaffoldBackgroundColor:MyColors.sacaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0, color: MyColors.sacaffoldBackgroundColor),
    iconTheme: const IconThemeData(color: MyColors.lightBottomNavbarUnSelectedColor),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: MyColors.lightTitleColor),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => MyColors.lightText2Color),
      overlayColor:  MaterialStateColor.resolveWith((states) => MyColors.lightText2Color),
    ),

    colorScheme: const ColorScheme.light(
      primary: MyColors.lightTitleColor ,
      onPrimary: MyColors.lightText2Color,
      primaryContainer: MyColors.lightText3Color,
      secondary: MyColors.lightTextFieldColor,
      secondaryContainer:MyColors.white,
      error: MyColors.red
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 1.h,
      backgroundColor: MyColors.white,
      selectedItemColor: MyColors.lightBottomNavbarSelectedColor,
      unselectedItemColor: MyColors.lightBottomNavbarUnSelectedColor,
      selectedIconTheme: const IconThemeData(color: MyColors.lightBottomNavbarSelectedColor),
      showUnselectedLabels: true,
    ),
  );
}


