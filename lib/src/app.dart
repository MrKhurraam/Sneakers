import 'package:flutter/material.dart';
import 'helpers/app_colors.dart';
import 'screens/catalog_screen.dart';
import 'package:get/get.dart';

import 'screens/welcome_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.MAIN_COLOR,
          secondary: AppColors.TEXT_COLOR,
        ),
        fontFamily: 'Raleway',
        textTheme: Theme.of(context).textTheme.apply(
              displayColor: AppColors.TEXT_COLOR,
              bodyColor: AppColors.TEXT_COLOR,
            ),
      ),
      home: SplashPage(),
    );
  }
}
