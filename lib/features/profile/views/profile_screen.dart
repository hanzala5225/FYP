import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/commons/common_widgets/custom_appbar.dart';
import 'package:rental_app/features/auth/controller/auth_controller.dart';
import 'package:rental_app/features/auth/controller/auth_notifier_controller.dart';
import 'package:rental_app/routes/route_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../widgets/setting_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 65.h,),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final authNotiCtr = ref.watch(authNotifierCtr);
                return Text(authNotiCtr.userModel?.name ?? "User", style: getMediumStyle(
                    fontSize: MyFonts.size24,
                    isNats: true
                ),);
              },

            ),
            Divider(color: MyColors.lightGreyColor, thickness: 1.h,height: 0),
            SizedBox(height: 110.h,),

            SettingsTile(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.contactUsScreen);
              },
              buttonName: "Contact Us",
            ),
            SettingsTile(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.profileTermsAndConditionsScreen);
              },
              buttonName: "Terms And Conditions",
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return SettingsTile(
                  onTap: (){
                    ref.read(authControllerProvider.notifier).logout(context: context);
                  },
                  buttonName: "Logout",
                );
              },

            ),
          ],
        ),
      ),
    );
  }
}
