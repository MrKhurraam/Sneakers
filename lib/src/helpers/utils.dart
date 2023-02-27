import 'package:get/get.dart';
import 'package:sneakers/src/helpers/app_colors.dart';

import '../models/product_model.dart';

class Utils {
  static List<Product> allProductList = [
    Product(
      name: 'Sketcher',
      price: 16999,
      imageUrl: [
        'assets/sketcher/1.jpg',
        'assets/sketcher/2.jpeg',
        'assets/sketcher/3.jpeg'
      ],
    ),
    Product(
      name: 'Power',
      price: 7999,
      imageUrl: [
        'assets/power/1.jpg',
        'assets/power/2.jpg',
        'assets/power/3.jpg'
      ],
    ),
    Product(
      name: 'NorthStar',
      price: 4999,
      imageUrl: [
        'assets/northstar/1.jpg',
        'assets/northstar/2.jpg',
        'assets/northstar/3.jpg'
      ],
    ),
    Product(
      name: 'Sneakers',
      price: 4999,
      imageUrl: [
        'assets/sneakers/1.jpg',
        'assets/sneakers/2.jpg',
        'assets/sneakers/3.jpg'
      ],
    ),
    Product(
      name: 'Weinbrenner',
      price: 4999,
      imageUrl: [
        'assets/weinbrenner/1.jpg',
        'assets/weinbrenner/2.jpg',
        'assets/weinbrenner/3.jpg'
      ],
    ),
  ];

  static showSnakBar(title, msg) {
    return Get.snackbar(
      '$title',
      '$msg',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 1),
      backgroundColor: AppColors.MAIN_COLOR,
      colorText: AppColors.BACKGROUND_COLOR,
    );
  }
}
