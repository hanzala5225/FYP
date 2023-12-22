import 'package:rental_app/utils/constants/assets_manager.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/cached_retangular_network_image.dart';

class SearchItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final VoidCallback onTap;
  const SearchItemCard({Key? key, required this.imagePath, required this.title, required this.price, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedRectangularNetworkImageWidget(
                image: imagePath,
                width: 265,
                height: 110
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 10.h,),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 130.w
                    ),
                    child: Text(title,
                      overflow: TextOverflow.ellipsis,
                      style: getMediumStyle(
                        color: MyColors.lightTitleColor,
                        fontSize: MyFonts.size14
                    ),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rs. ${price}", style: getMediumStyle(
                          color: MyColors.lightThemeColor,
                          fontSize: MyFonts.size14
                      ),),
                      Image.asset(
                        AppAssets.cartIcon,
                        width: 16.w, height: 16.h,
                        color: MyColors.lightThemeColor,
                      )
                    ],
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
