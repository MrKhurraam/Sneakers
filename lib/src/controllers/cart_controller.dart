import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/utils.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  var _cartProducts = {}.obs;

  get cartProducts => _cartProducts;

  addProduct(Product product) {
    if (_cartProducts.containsKey(product)) {
      _cartProducts[product] += 1;
    } else {
      _cartProducts[product] = 1;
    }

    Utils.showSnakBar(
        'Product Added', 'You have added ${product.name} to cart.');
  }

  removeProduct(Product product) {
    if (_cartProducts.containsKey(product) && _cartProducts[product] == 1) {
      _cartProducts.remove(product);
    } else {
      _cartProducts[product] -= 1;
    }

    Utils.showSnakBar(
        'Product Removed', 'You have Remove ${product.name} from cart.');
  }

  get subTotal => _cartProducts.entries.map((product) {
        product.key.price * product.value;
      });

  get total => _cartProducts.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toString();
}
