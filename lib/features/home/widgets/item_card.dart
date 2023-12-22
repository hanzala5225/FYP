import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:rental_app/commons/common_widgets/custom_button.dart';
import 'package:rental_app/features/cart/controllers/cart_noti_controller.dart';
import 'package:rental_app/features/home/data/models/item_model.dart';
import 'package:rental_app/routes/route_manager.dart';

import '../../../commons/common_imports/common_libs.dart';

class ItemCard extends StatelessWidget {
  final ItemModel itemModel;
  const ItemCard({Key? key, required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.itemDetailsScreen, arguments: {
          "itemModel" : itemModel
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: MyColors.white,
          boxShadow: [
            BoxShadow(
              color:  MyColors.black.withOpacity(0.2),
              // spreadRadius: 12,
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        margin: EdgeInsets.only(right: 10.w, bottom: 12.h),
        constraints: BoxConstraints(
          minWidth: 265.w,
          maxWidth: 265.w,
          minHeight: 220.h
        ),
        child: Column(
          children: [
            CachedRectangularNetworkImageWidget(
                image: itemModel.itemImages[0],
                width: 265,
                height: 150
            ),
            SizedBox(height: 12.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 12.w),
                  child: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final cartCtr = ref.watch(cartNotiController);
                      return CustomButton(
                          buttonWidth: 150.w,
                          onPressed: (){
                            cartCtr.addToCart(itemModel);
                          },
                          buttonText: "Rent"
                      );
                    },

                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 12.w, left: 10.w),
                  child: Text("Rs. 300", style: getSemiBoldStyle(fontSize: MyFonts.size16),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
