import 'package:flutter/material.dart';
import 'package:rental_app/commons/common_imports/common_libs.dart';
import 'package:rental_app/utils/constants/assets_manager.dart';
import '../../utils/constants/font_manager.dart';
import '../../utils/thems/styles_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({this.showBackButton = false});
  final bool showBackButton;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title:  Text(
        "Rental",
        style: getRegularStyle(
          fontSize: MyFonts.size18,
          isNats: true
        ),),
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton ? IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Image.asset(AppAssets.arrowLeft, height: 14.h, width: 14.w, color: MyColors.lightTitleColor,)
      ) : const SizedBox(),
    );
  }
}