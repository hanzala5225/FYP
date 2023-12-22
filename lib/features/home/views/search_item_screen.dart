import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/commons/common_widgets/CustomTextFields.dart';
import 'package:rental_app/features/home/data/models/item_model.dart';
import 'package:rental_app/features/home/data/models/search_parameters_model.dart';
import 'package:rental_app/utils/constants/assets_manager.dart';
import 'package:rental_app/utils/loading.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/custom_appbar.dart';
import '../../../routes/route_manager.dart';
import '../../../utils/utils.dart';
import '../controllers/home_noti_controller.dart';
import '../widgets/filter_dialouge.dart';
import '../widgets/search_item_card.dart';

class SearchItemScreen extends ConsumerStatefulWidget {
  const SearchItemScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchItemScreen> createState() => _SearchItemScreenState();
}

class _SearchItemScreenState extends ConsumerState<SearchItemScreen> {
  final searchCtr = TextEditingController();

  @override
  void dispose() {
    searchCtr.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                      controller: searchCtr,
                      hintText: "Search here...",
                      onChanged: (val){
                        setState(() {
                        });
                      },
                      onFieldSubmitted: (val){},
                      obscure: false,
                      label: "",
                    tailingIcon: Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Image.asset(AppAssets.searchIcon, width: 20.w, height: 20.h,),
                    )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    showGeneralDialog(
                      barrierLabel: "Label",
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: const Duration(milliseconds: 200),
                      context: context,
                      pageBuilder: (context, anim1, anim2) {
                        return Align(
                            alignment: Alignment.topRight, child: FilterDialouge(
                          ascendingPrice: (val){
                            ref.watch(homeNotiController).setPrice(val);
                          },
                          ascendingRating: (val){
                            ref.watch(homeNotiController).setRating(val);
                          },
                        ));
                      },
                      transitionBuilder: (context, anim1, anim2, child) {
                        return SlideTransition(
                          position: Tween(
                              begin: const Offset(1, 0), end: const Offset(0, 0))
                              .animate(anim1),
                          child: child,
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 45.h,
                    alignment: Alignment.center,
                    margin:  EdgeInsets.only(left: 20.w, top: 24.h),
                    child: Image.asset(AppAssets.filterIcon, width: 24.w, height: 24.h,)),
                ),
              ],
            ),
            SizedBox(height: 26.h,),
            ref.watch(fetchAllItemsController(SearchParametersModel(
                searchWord: "",
                desscendingPrice: ref.watch(homeNotiController).price,
                descendingRating: ref.watch(homeNotiController).rating)
            )).when(
                data: (items){
                  print(items.length);
                  return ref.watch(searchAllItemsController(SearchParametersModel(
                      searchWord: searchCtr.text,
                      desscendingPrice: ref.watch(homeNotiController).price,
                      descendingRating: ref.watch(homeNotiController).rating
                  ))).when(data: (itemsList){
                    return itemsList.isEmpty ?
                    Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          ItemModel model = items[index];
                          return SearchItemCard(
                            onTap: (){
                              Navigator.pushNamed(context, AppRoutes.itemDetailsScreen, arguments: {
                                "itemModel" : model
                              });
                            },
                            title: model.itemName,
                            imagePath: model.itemImages[0],
                            price: model.itemPrice.toString(),
                          );
                        },
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 12.w,
                          crossAxisSpacing: 12.h,
                        ),
                      ),
                    ):
                    Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: itemsList.length,
                        itemBuilder: (context, index) {
                          ItemModel model = itemsList[index];
                          return SearchItemCard(
                            onTap: (){
                              Navigator.pushNamed(context, AppRoutes.itemDetailsScreen, arguments: {
                                "itemModel" : model
                              });
                            },
                            title: model.itemName,
                            imagePath: model.itemImages[0],
                            price: model.itemPrice.toString(),
                          );
                        },
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 12.w,
                          crossAxisSpacing: 12.h,
                        ),
                      ),
                    );
                  },
                      error: (error, st){
                        debugPrintStack(stackTrace: st);
                        debugPrint(error.toString());
                        return SizedBox();
                      },
                      loading: (){
                        return const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: LoadingWidget(),
                            )
                          ],
                        );
                      }
                  );
                },
                error: (error, st){
                  debugPrintStack(stackTrace: st);
                  debugPrint(error.toString());
                  return SizedBox();
                },
                loading: (){
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: LoadingWidget(),
                      )
                    ],
                  );
                }
            ),

          ],
        ),
      ),
    );
  }
}
