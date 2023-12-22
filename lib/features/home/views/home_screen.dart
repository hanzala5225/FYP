import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/routes/route_manager.dart';
import 'package:rental_app/utils/constants/assets_manager.dart';
import 'package:rental_app/utils/loading.dart';
import '../../../commons/common_imports/common_libs.dart';
import '../controllers/home_noti_controller.dart';
import '../data/models/home_category_model.dart';
import '../widgets/home_category_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Welcome!", style: getMediumStyle(fontSize: MyFonts.size32, isNats: true),),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.profileScreen);
                  },
                    child: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: Image.asset(AppAssets.profileIcon, )))
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.searchItemScreen);
              },
              child: Container(
                height: 45.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MyColors.lightTextFieldColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Search here...", style: getRegularStyle(fontSize: MyFonts.size14,),),
                    Image.asset(AppAssets.searchIcon, width: 20.w, height: 20.h,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h,),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return ref.watch(fetchAllCategoriesController).when(
                    data: (categories){
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          HomeCategoryModel model = categories[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 24.h),
                            child: HomeCategorySection(homeCategoryModel: model,),
                          );
                        },
                      );
                    },
                    error: (error, st){
                      debugPrintStack(stackTrace: st);
                      debugPrint(error.toString());
                      return SizedBox();
                    },
                    loading: (){
                      return LoadingWidget();
                    }
                );

              },

            )
          ],
        ),
      ),
    );
  }
}
