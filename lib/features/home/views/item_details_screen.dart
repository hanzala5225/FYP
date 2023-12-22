import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/commons/common_widgets/cached_retangular_network_image.dart';
import 'package:rental_app/commons/common_widgets/custom_appbar.dart';
import 'package:rental_app/commons/common_widgets/custom_button.dart';
import 'package:rental_app/features/cart/controllers/cart_noti_controller.dart';
import 'package:rental_app/features/home/data/models/item_model.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/constants/assets_manager.dart';

class ItemDetailsScreen extends StatelessWidget {
  final ItemModel itemModel;
  const ItemDetailsScreen({Key? key, required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedRectangularNetworkImageWidget(
                    image: itemModel.itemImages[0],
                    width: 375,
                    height: 400
                ),
                Positioned(
                  top: 50.h,
                  left: 10.w,
                  child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Image.asset(AppAssets.arrowLeft, height: 18.h, width: 18.w, color: MyColors.white,)
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 200.w
                        ),
                        child: Text(itemModel.itemName, style: getSemiBoldStyle(
                          fontSize: MyFonts.size16,
                        ),),
                      ),
                      Text("Rs. ${itemModel.itemPrice}/${itemModel.rentTypeEnum.type} ", style: getSemiBoldStyle(
                        fontSize: MyFonts.size18,
                        color: MyColors.lightThemeColor
                      ),),
                    ],
                  ),
                  SizedBox(height: 6.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rating", style: getMediumStyle(
                        fontSize: MyFonts.size14,
                      ),),
                      Row(
                        children: List.generate(5,
                                (index) => Image.asset(AppAssets.starIcon, width: 14.w, height: 14.h,)),
                      )
                    ],
                  ),
                  SizedBox(height: 6.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Availability", style: getMediumStyle(
                        fontSize: MyFonts.size14,
                      ),),
                      Text(itemModel.isAvailable ? "yes" : "No", style: getMediumStyle(
                        fontSize: MyFonts.size14,
                      ),),
                    ],
                  ),
                  SizedBox(height: 6.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Owner", style: getMediumStyle(
                        fontSize: MyFonts.size14,
                      ),),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: 150.w
                        ),
                        child: Text(itemModel.ownerName, style: getMediumStyle(
                          fontSize: MyFonts.size14,
                        ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 26.h,),
                  Divider(
                    thickness: 0.1.h,
                    color: MyColors.lightText3Color,
                  ),
                  SizedBox(height: 10.h,),
                  Text("Description", style: getSemiBoldStyle(
                    fontSize: MyFonts.size16,
                  ),),
                  SizedBox(height: 4.h,),
                  Text(itemModel.itemDescription,
                    style: getMediumStyle(
                    fontSize: MyFonts.size12,
                    color: MyColors.lightText2Color
                  ),),
                  SizedBox(height: 30.h,),
                  Center(
                    child: Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        final cartCtr = ref.watch(cartNotiController);
                        return CustomButton(
                            onPressed: (){
                              cartCtr.addToCart(itemModel);
                            },
                            buttonText: "Add to cart"
                        );
                      },

                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
