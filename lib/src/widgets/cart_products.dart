import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers/src/controllers/cart_controller.dart';
import 'package:sneakers/src/helpers/app_colors.dart';

class CartProductCard extends StatelessWidget {
  CartProductCard(
      {Key? key,
      required this.product,
      required this.controller,
      required this.index,
      required this.quantity})
      : super(key: key);
  var product;
  var quantity;
  var index;
  CartController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset.zero,
              blurRadius: 10,
            )
          ]),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Image.asset(
              product.imageUrl[0],
              // height: 25,
              // width: 25,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              '${product.name}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.TEXT_COLOR),
            ),
          ),
          IconButton(
              onPressed: () {
                controller.removeProduct(product);
              },
              icon: Icon(
                color: AppColors.MAIN_COLOR,
                Icons.remove_circle,
              )),
          Text(
            '${quantity}',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.TEXT_COLOR),
          ),
          IconButton(
              onPressed: () {
                controller.addProduct(product);
              },
              icon: Icon(
                color: AppColors.MAIN_COLOR,
                Icons.add_circle,
              )),
        ],
      ),
    );
  }
}
