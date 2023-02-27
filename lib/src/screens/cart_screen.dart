import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers/src/helpers/app_colors.dart';
import 'package:sneakers/src/widgets/my_appbar.dart';

import '../controllers/cart_controller.dart';
import '../widgets/cart_products.dart';
import '../widgets/cart_total.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: MyAppBar(
        title: 'My Cart',
      ),
      body: Container(
        child: cartController.cartProducts.length > 0
            ? Obx(
                () {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartController.cartProducts.length,
                      itemBuilder: (context, index) {
                        return CartProductCard(
                            product: cartController.cartProducts.keys
                                .toList()[index],
                            quantity: cartController.cartProducts.values
                                .toList()[index],
                            index: index,
                            controller: cartController);
                      });
                },
              )
            : Center(
                child: Text(
                  "Your Cart has no item!",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: AppColors.TEXT_COLOR),
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: cartController.cartProducts.length == 0
          ? SizedBox.shrink()
          : Container(
              // color: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 20),
              margin: EdgeInsets.only(left: 40, right: 40),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(() {
                    return Text(
                      "Rs. ${cartController.total}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  }),
                ],
              )),
    );
  }
}
