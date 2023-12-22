import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/font_manager.dart';
import '../../utils/thems/my_colors.dart';
import '../../utils/thems/styles_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final TextInputType? inputType;
  final bool obscure;
  final IconData? icon;
  final String? Function(String?)? validatorFn;
  final Widget? leadingIcon;
  final Widget? tailingIcon;
  final String? leadingIconPath;
  final double? texfieldHeight;
  final String label;
  final bool showLabel;

  const  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onFieldSubmitted,
    this.inputType,
    this.leadingIcon,
    required this.obscure,
    this.validatorFn,
    this.icon,
    this.tailingIcon,
    this.leadingIconPath,
    this.texfieldHeight,
    required this.label,
    this.showLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getSemiBoldStyle(
              fontSize: MyFonts.size12,
              color: MyColors.lightTitleColor),
        ),
        SizedBox(height: 6.h,),
        Container(
          decoration: BoxDecoration(
            color: MyColors.lightTextFieldColor,
            borderRadius: BorderRadius.circular(8.r)
          ),
          child: TextFormField(
            validator: validatorFn,
            obscureText: obscure,
            controller: controller,
            keyboardType: inputType,
            style:
                getMediumStyle(fontSize: MyFonts.size12, color: MyColors.lightTitleColor),
            decoration: InputDecoration(
              fillColor: MyColors.lightTextFieldColor,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              errorStyle: getRegularStyle(
                  fontSize: MyFonts.size10,
                  color: Theme.of(context).colorScheme.error),
              suffixIcon: tailingIcon,
              hintText: hintText,
              hintStyle: getMediumStyle(
                  fontSize: MyFonts.size12,
                  color: MyColors.lightText2Color),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: MyColors.transparentColor,
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: MyColors.transparentColor,
                )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: MyColors.transparentColor,
                )
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: MyColors.transparentColor,
                )
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: MyColors.transparentColor,
                )
              ),
            ),
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
