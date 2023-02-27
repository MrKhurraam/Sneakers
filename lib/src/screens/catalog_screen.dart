import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers/src/controllers/product_controller.dart';
import 'package:sneakers/src/helpers/app_colors.dart';
import '../controllers/cart_controller.dart';
import '../helpers/utils.dart';
import '../models/product_model.dart';
import '../widgets/my_appbar.dart';
import 'cart_screen.dart';
import 'catalog_details.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: MyAppBar(
        title: 'Sneakers',
      ),
      body: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: List.generate(
          Utils.allProductList.length,
          (index) {
            var prod = Utils.allProductList[index];
            return GestureDetector(
              onTap: () {
                productController.selectedProduct = Utils.allProductList[index];
                Get.to(
                  CatalogDetails(),
                  transition: Transition.fadeIn,
                  duration: Duration(seconds: 1),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 7),
                    height: Get.width * 0.4,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(prod.imageUrl[0]),
                          fit: BoxFit.contain,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset.zero,
                            blurRadius: 7,
                          )
                        ]),
                    // child: Image.asset(prod.imageUrl[0]),
                  ),
                  Text(
                    "${prod.name}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.TEXT_COLOR),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
