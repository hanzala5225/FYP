import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/commons/common_widgets/custom_button.dart';
import 'package:rental_app/features/cart/controllers/cart_noti_controller.dart';
import 'package:rental_app/features/home/data/models/item_model.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../utils/utils.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cart Items", style: getMediumStyle(fontSize: MyFonts.size32, isNats: true),),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final cartCtr = ref.watch(cartNotiController);
                return cartCtr.cartIetms.length == 0 ?
                const NoRecordFound(message: "No Items Found!",):
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartCtr.cartIetms.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    ItemModel model  = cartCtr.cartIetms[index];
                    return CartItemCard(
                      onRemove: (){
                        cartCtr.removeItem(model);
                      },
                      price: model.itemPrice.toString(),
                      imagePath:  model.itemImages[0],
                      title: model.itemName,
                    );
                  },
                );
              },

            ),
            SizedBox(height: 30.h,),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final cartCtr = ref.watch(cartNotiController);
                return cartCtr.cartIetms.length == 0 ?
                const SizedBox():
                Center(
                  child: CustomButton(
                    isLoading: cartCtr.isLoading,
                      onPressed: (){
                      cartCtr.clearCart();
                      },
                      buttonText: "Order Rent"
                  ),
                );
              },

            ),
            SizedBox(height: 30.h,)
          ],
        ),
      ),
    );
  }
}
