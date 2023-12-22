import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_app/utils/thems/my_colors.dart';
import '../constants/font_manager.dart';


class Font {
  static const natsFont = 'NATS';
  static const poppins = 'Poppins';
}


TextStyle _getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color,
    double letterSpacing,
    bool isNats,
    ) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: isNats ? Font.natsFont : Font.poppins,
    letterSpacing: letterSpacing,

  );
}

// regular style
TextStyle getRegularStyle({
  double fontSize = 14,
  double letterSpacing = 0,
  Color color = MyColors.lightTitleColor,
  bool isNats = false
}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.regular, color, letterSpacing, isNats);
}

// medium style
TextStyle getMediumStyle({
  double fontSize = 16,
  double letterSpacing = 0,
  Color color = MyColors.lightTitleColor,
  bool isNats = false
}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.medium, color, letterSpacing, isNats);
}

// medium style
TextStyle getLightStyle({
  double fontSize = 14,
  double letterSpacing = 0,
  Color color = MyColors.lightTitleColor,
  bool isNats = false
}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.light, color, letterSpacing, isNats);
}

// bold style
TextStyle getBoldStyle({
  double fontSize = 14,
  double letterSpacing = 0,
  Color color = MyColors.lightTitleColor,
  bool isNats = false
}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.bold, color, letterSpacing, isNats);
}

// semibold style
TextStyle getSemiBoldStyle({
  double fontSize = 14,
  double letterSpacing = 0,
  Color color = MyColors.lightTitleColor,
  bool isNats = false
}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.semiBold, color, letterSpacing, isNats);
}

// bold style
TextStyle getExtraBoldStyle({
  double fontSize = 14,
  double letterSpacing = 0,
  Color color = MyColors.lightTitleColor,
  bool isNats = false
}) {
  return _getTextStyle(fontSize.sp, FontWeightManager.extraBold, color, letterSpacing, isNats);
}
