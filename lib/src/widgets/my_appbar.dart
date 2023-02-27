import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers/src/screens/cart_screen.dart';

import '../controllers/cart_controller.dart';
import '../helpers/app_colors.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Size get preferredSize => new Size.fromHeight(70);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.MAIN_COLOR),
      title: Text(
        this.widget.title.toString(),
        style: TextStyle(
          color: AppColors.MAIN_COLOR,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(
              CartScreen(),
              transition: Transition.fadeIn,
              duration: Duration(seconds: 1),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 3, bottom: 13, right: 20),
            child: Obx(() {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 27,
                    color: AppColors.MAIN_COLOR,
                  ),
                  Positioned.fill(
                      top: 1.5,
                      left: 9,
                      child: Text(
                        cartController.cartProducts.length == 0
                            ? ''
                            : '${cartController.cartProducts.length}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.TEXT_COLOR,
                        ),
                      )),
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
