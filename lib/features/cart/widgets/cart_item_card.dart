import 'package:rental_app/commons/common_widgets/custom_button.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/cached_retangular_network_image.dart';

class CartItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final VoidCallback onRemove;
  const CartItemCard({Key? key, required this.imagePath, required this.title, required this.price, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: MyColors.white,
        boxShadow: [
          BoxShadow(
            color:  MyColors.black.withOpacity(0.04),
            blurRadius: 35.r,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedRectangularNetworkImageWidget(
              image: imagePath,
              width: 150,
              height: 160
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 120.w
                    ),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: getMediumStyle(
                        color: MyColors.lightTitleColor,
                        fontSize: MyFonts.size14
                    ),),
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rent", style: getMediumStyle(
                          color: MyColors.lightTitleColor,
                          fontSize: MyFonts.size14
                      ),),
                      Text("\$ ${price}", style: getMediumStyle(
                          color: MyColors.lightText2Color,
                          fontSize: MyFonts.size12
                      ),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Duration", style: getMediumStyle(
                          color: MyColors.lightTitleColor,
                          fontSize: MyFonts.size14
                      ),),
                      Text("Month", style: getMediumStyle(
                          color: MyColors.lightText2Color,
                          fontSize: MyFonts.size12
                      ),),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  CustomButton(
                    buttonHeight: 40.h,
                      fontSize: MyFonts.size16,
                      onPressed: onRemove,
                      buttonText: "Remove Item"
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
