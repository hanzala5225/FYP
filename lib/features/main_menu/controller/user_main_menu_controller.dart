import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_app/features/cart/views/cart_screen.dart';
import '../../home/views/home_screen.dart';
import '../../my_products/views/my_products_screen.dart';


final mainMenuProvider = ChangeNotifierProvider((ref) => MainMenuController());

class MainMenuController extends ChangeNotifier{

  List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const MyProductsScreen(),
  ];


  int _index = 0;
  int get index => _index;
  setIndex(int id){
    _index = id;
    notifyListeners();
  }

}