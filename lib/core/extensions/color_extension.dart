import 'package:flutter/material.dart';

extension ThemeColors on BuildContext {
  Color get whiteColor => Theme.of(this).colorScheme.secondaryContainer;
  Color get text1Color => Theme.of(this).colorScheme.primary;
  Color get text2Color => Theme.of(this).colorScheme.onPrimary;
  Color get text3Color => Theme.of(this).colorScheme.primaryContainer;
  Color get textFieldBackgroundColor => Theme.of(this).colorScheme.secondary;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
}
