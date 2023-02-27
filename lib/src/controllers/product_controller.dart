import 'package:get/get.dart';

import '../models/product_model.dart';

class ProductController extends GetxController {
  late Product _selectedProduct;

  set selectedProduct(Product pr) => _selectedProduct = pr;

  Product get selectedProduct => _selectedProduct;

}