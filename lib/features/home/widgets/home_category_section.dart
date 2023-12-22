import 'package:rental_app/features/home/widgets/item_card.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../data/models/home_category_model.dart';
import '../data/models/item_model.dart';

class HomeCategorySection extends StatelessWidget {
  final HomeCategoryModel homeCategoryModel;
  const HomeCategorySection({Key? key, required this.homeCategoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          homeCategoryModel.categoryName,
          style: getBoldStyle(
          )
        ),
        SizedBox(height: 12.h,),
        SizedBox(
          height: 250.h,
          width: 375.w,
          child: ListView.builder(
            itemCount: homeCategoryModel.itemsList.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              ItemModel model = homeCategoryModel.itemsList[index];
              return ItemCard(itemModel: model,);
            },
          ),
        ),

      ],
    );
  }
}
