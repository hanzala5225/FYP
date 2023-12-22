import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/commons/common_widgets/show_toast.dart';
import 'package:rental_app/features/home/data/models/item_model.dart';


final cartNotiController = ChangeNotifierProvider((ref) {
  return CartNotiController();
}
);

class CartNotiController extends ChangeNotifier{
  bool _isLoading= false;
  bool get isLoading =>  _isLoading;
  setLoading(bool stat){
    _isLoading = stat;
    notifyListeners();
  }


  List<ItemModel>_cartIetms = [];
  List<ItemModel> get cartIetms =>_cartIetms;
  addToCart(ItemModel model){
    if(_cartIetms.contains(model)){
      showToast(msg: "Item Already In The Cart!");
    }else{
      _cartIetms.add(model);
      showToast(msg: "Item Added To Cart!");
    }
    notifyListeners();
  }

  removeItem(ItemModel model){
    if(_cartIetms.contains(model)){
      _cartIetms.remove(model);
    }
    notifyListeners();
  }

  clearCart(){
    setLoading(true);
    Future.delayed(Duration(seconds: 1), (){
      _cartIetms = [];
      showToast(msg: "Order Placed Successfully!");
      setLoading(false);
    });
  }
}