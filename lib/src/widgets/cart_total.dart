import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers/src/controllers/cart_controller.dart';

class CartTotal extends StatelessWidget {
  const CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Total',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() {
              return Text(
                "${cartController.total}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
          ],
        ));
  }
}
