import 'package:flutter/material.dart';
import 'package:rental_app/features/auth/view/signup_screen.dart';
import 'package:rental_app/features/home/views/item_details_screen.dart';
import 'package:rental_app/features/home/views/search_item_screen.dart';
import 'package:rental_app/features/location_access/views/location_access_screen.dart';
import 'package:rental_app/features/main_menu/views/main_menu_screen.dart';
import 'package:rental_app/features/on_boarding/views/on_boarding_screen.dart';
import 'package:rental_app/features/profile/views/contact_us_screen.dart';
import 'package:rental_app/features/profile/views/profile_terms_and_conditions_screen.dart';
import 'package:rental_app/features/terms_and_conditions/views/term_and_conditions_screen.dart';
import '../features/auth/view/signin_screen.dart';
import '../features/cart/views/cart_screen.dart';
import '../features/home/views/home_screen.dart';
import '../features/profile/views/profile_screen.dart';
import 'navigation.dart';

class AppRoutes {

  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String termsAndConditionsScreen = '/termsAndConditionsScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String locationAccessScreen = '/locationAccessScreen';
  static const String homeScreen = '/homeScreen';
  static const String mainMenuScreen = '/mainMenuScreen';
  static const String searchItemScreen = '/searchItemScreen';
  static const String itemDetailsScreen = '/itemDetailsScreen';
  static const String cartScreen = '/cartScreen';
  static const String profileScreen = '/profileScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String profileTermsAndConditionsScreen = '/profileTermsAndConditionsScreen';



  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case signInScreen:
        return _buildRoute(const SignInScreen());
      case signUpScreen:
        return _buildRoute(const SignUpScreen());
      case termsAndConditionsScreen:
        return _buildRoute(const TermsAndConditionScreen());
      case onBoardingScreen:
        return _buildRoute(const OnBoardingScreen());
      case locationAccessScreen:
        return _buildRoute(const LocationAccessScreen());
      case homeScreen:
        return _buildRoute(const HomeScreen());
      case mainMenuScreen:
        return _buildRoute(const MainMenuScreen());
      case searchItemScreen:
        return _buildRoute(const SearchItemScreen());
      case cartScreen:
        return _buildRoute(const CartScreen());
      case profileScreen:
        return _buildRoute(const ProfileScreen());
      case contactUsScreen:
        return _buildRoute(const ContactUsScreen());
      case profileTermsAndConditionsScreen:
        return _buildRoute(const ProfileTermsAndConditionsScreen());
      case itemDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildRoute( ItemDetailsScreen(
          itemModel: args["itemModel"],
        ));


      default:
        return unDefinedRoute();
    }
  }

  static unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              backgroundColor: Colors.white,
            ));

  }

  static _buildRoute(Widget widget, {int? duration = 300}) {
    return forwardRoute(widget, duration);
  }

  static _buildNormalRoute(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }
}
