import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers/src/screens/catalog_details.dart';
import 'package:sneakers/src/screens/catalog_screen.dart';

import '../helpers/app_colors.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..addListener(() {
        setState(() {});
      });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.reverse) {
        Get.off(
          CatalogScreen(),
          transition: Transition.fadeIn,
          // duration: Duration(milliseconds: 1),
        );
      }
    });

    controller.repeat(reverse: true);
    super.initState();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACKGROUND_COLOR,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Text(
                "Welcome to Sneaekers",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: AppColors.TEXT_COLOR),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 10,
              width: Get.width * 0.7,
              // child: CircularProgressIndicator(
              //   strokeWidth: 10,
              //   color: Colors.white,
              // ),
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                value: controller.value,
                color: AppColors.MAIN_COLOR,
              ),
              // CircularProgressIndicator(
              //
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
