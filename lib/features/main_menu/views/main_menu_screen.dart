import 'package:rental_app/commons/common_widgets/custom_appbar.dart';
import 'package:rental_app/features/home/controllers/home_noti_controller.dart';

import '../../../commons/common_imports/apis_commons.dart';
import '../../../commons/common_imports/common_libs.dart';
import '../../../models/user_model.dart';
import '../../../utils/constants/assets_manager.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/controller/auth_notifier_controller.dart';
import '../controller/user_main_menu_controller.dart';

class MainMenuScreen extends ConsumerStatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen> {


  @override
  void initState() {
    super.initState();
    initialization();
  }

  /// Here in this method, we are initializing necessary methods
  initialization() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authCtr = ref.read(authControllerProvider.notifier);
      UserModel userModel = await authCtr.getCurrentUserInfo();
      final authNotifierProvider = ref.read(authNotifierCtr.notifier);
      authNotifierProvider.setUserModelData(userModel);
      // await ref.watch(homeNotiController).uploadAllCategories();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final mainMenuCtr = ref.watch(mainMenuProvider);
          return PageView(
            children: [
              mainMenuCtr.screens[mainMenuCtr.index]
            ],
          );
        },

      ),
      bottomNavigationBar: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final mainMenuCtr = ref.watch(mainMenuProvider);
          return Theme(
            data: Theme.of(context).copyWith(
              canvasColor: MyColors.white,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: mainMenuCtr.index,
              elevation: 10,
              iconSize: 24.sp,
              backgroundColor: MyColors.white,
              unselectedLabelStyle: getSemiBoldStyle(
                fontSize: MyFonts.size10,
                color: MyColors.lightBottomNavbarUnSelectedColor,
              ),
              selectedLabelStyle: getSemiBoldStyle(
                fontSize: MyFonts.size10,
                color: MyColors.lightThemeColor
              ),
              onTap: (id){
                mainMenuCtr.setIndex(id);
              },
              items:  [
                BottomNavigationBarItem(
                    icon: Image.asset(AppAssets.homeIcon,
                      color: mainMenuCtr.index == 0? MyColors.lightThemeColor: MyColors.lightBottomNavbarUnSelectedColor,
                      height: 22.h,
                      width: 22.w,
                    ),
                    label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(AppAssets.cartIcon,
                      color: mainMenuCtr.index == 1? MyColors.lightThemeColor: MyColors.lightBottomNavbarUnSelectedColor,
                      height: 22.h,
                      width: 22.w,
                    ),
                    label: "Cart",
                ),
                BottomNavigationBarItem(
                    icon:Image.asset(AppAssets.myProductsIcon,
                      color: mainMenuCtr.index == 2? MyColors.lightThemeColor: MyColors.lightBottomNavbarUnSelectedColor,
                      height: 22.h,
                      width: 22.w,
                    ),
                    label: "My products",
                ),
              ],
            ),
          );
        },

      ),
    );
  }
}
