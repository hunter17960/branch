import 'package:branch/core/themes/colors.dart';
import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  primaryColor: ColorsManager.mainBlue,
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorsManager.mainBlue,
    centerTitle: true,
    iconTheme: IconThemeData(color: ColorsManager.white),
  ),
  useMaterial3: true,
);
