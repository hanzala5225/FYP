
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/features/home/controllers/home_noti_controller.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../location_access/widgets/custom_radio.dart';

class FilterDialouge extends StatefulWidget {
  final Function(bool isAscendingPrice) ascendingPrice;
  final Function(bool isAscendingRating) ascendingRating;
  const FilterDialouge({super.key, required this.ascendingPrice, required this.ascendingRating});

  @override
  State<FilterDialouge> createState() => _FilterDialougeState();
}

class _FilterDialougeState extends State<FilterDialouge> {
  int selectedValue = 3;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.h,
      width: 250.w,
      margin: const EdgeInsets.only(right: 12, top: 85),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: ref.watch(homeNotiController).price,
                          checkColor: MyColors.lightThemeColor,
                          onChanged: (val){
                            widget.ascendingPrice(val as bool);
                          }
                      ),
                      Text("Price: High to Low",)
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: ref.watch(homeNotiController).rating,
                          checkColor: MyColors.lightThemeColor,
                          onChanged: (val){
                            widget.ascendingRating(val as bool);
                          }
                      ),
                      Text( "Rating: High to Low",)
                    ],
                  ),
                ],
              );
            },

          ),
        ),
      ),
    );
  }
}
