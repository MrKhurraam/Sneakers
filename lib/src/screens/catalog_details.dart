import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers/src/controllers/product_controller.dart';
import 'package:sneakers/src/controllers/product_detail_controller.dart';
import 'package:sneakers/src/helpers/app_colors.dart';
import 'package:sneakers/src/widgets/my_appbar.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart';
import 'cart_screen.dart';

class CatalogDetails extends StatefulWidget {
  CatalogDetails({Key? key}) : super(key: key);

  @override
  State<CatalogDetails> createState() => _CatalogDetailsState();
}

class _CatalogDetailsState extends State<CatalogDetails>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 0, end: Get.width).animate(controller)
      // animation = CurvedAnimation(parent: controller, curve: Curves.easeInCirc)
      ..addStatusListener((status) {
//         print('sta = $status');
//         if(status == AnimationStatus.completed){controller.reverse();}
//         else if(status == AnimationStatus.dismissed){controller.forward();}
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.find();
    Product product = productController.selectedProduct;

    final CartController cartController = Get.find();
    final ProductDetailController productDetailController =
        Get.put(ProductDetailController());
    // productDetailController.imgSelIndex.value = 0;

    return Scaffold(
      appBar: MyAppBar(
        title: '${product.name}',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GrowTransition(
              animation: animation,
              child: ShoesPicture(),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                product.imageUrl.length,
                (index) => GestureDetector(
                  onTap: () {
                    productDetailController.imgSelIndex.value = index;
                    productDetailController.pageController.animateToPage(index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInCirc);
                  },
                  child: Obx(() {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInCirc,
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 3,
                              color:
                                  productDetailController.imgSelIndex.value ==
                                          index
                                      ? AppColors.MAIN_COLOR
                                      : Colors.transparent),
                          image: DecorationImage(
                            image: AssetImage(product.imageUrl[index]),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset.zero,
                              blurRadius: 10,
                            )
                          ]),
                      // child: Image.asset(prod.imageUrl[0]),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.topRight,
              child: Text(
                'Price: ${product.price}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.MAIN_COLOR),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20, top: 10),
              alignment: Alignment.topRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: AppColors.BACKGROUND_COLOR,
                ),
                onPressed: () {
                  cartController.addProduct(product);
                },
                child: const Text(
                  "Add To Cart",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: AppColors.MAIN_COLOR,
                  ),
                ),
              ),
            )
          ],
        ),
      ),

      // AnimatedLogo(
      //   animation: animation,
      // ),
    );
  }
}

class ShoesPicture extends StatefulWidget {
  ShoesPicture({Key? key}) : super(key: key);

  @override
  State<ShoesPicture> createState() => _ShoesPictureState();
}

class _ShoesPictureState extends State<ShoesPicture> {
  ProductController productController = Get.find();
  final CartController cartController = Get.find();
  final ProductDetailController productDetailController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Product product = productController.selectedProduct;

    return Container(
      height: Get.width,
      width: Get.width,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset.zero,
              blurRadius: 10,
            )
          ]),
      // child: Image.asset(prod.imageUrl[0]),

      child: InteractiveViewer(
        child: PageView.builder(
          controller: productDetailController.pageController,
          onPageChanged: (value) {
            productDetailController.imgSelIndex.value = value;
          },
          itemCount: product.imageUrl.length,
          itemBuilder: (context, index) {
            return Transform(
              transform: Matrix4.identity(),
              // ..rotateX(productDetailController.imgSelIndex.value - index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(product.imageUrl[index]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          },
        ),
        // child: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20),
        //     image: DecorationImage(
        //       image: AssetImage(product.imageUrl[imgSelIndex.value]),
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition(
      {required this.child, required this.animation, super.key});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    print("sec build");
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  final _sizeTween = Tween<double>(begin: 0, end: Get.height);

  @override
  Widget build(BuildContext context) {
    print("sec build");
    ProductController productController = Get.find();
    Product product = productController.selectedProduct;
    var imgSelIndex = 0.obs;
    final CartController cartController = Get.find();

    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.bounceIn,
                    height: Get.width,
                    width: Get.width,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image:
                              AssetImage(product.imageUrl[imgSelIndex.value]),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset.zero,
                            blurRadius: 10,
                          )
                        ]),
                    // child: Image.asset(prod.imageUrl[0]),
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    product.imageUrl.length,
                    (index) => GestureDetector(
                      onTap: () {
                        imgSelIndex.value = index;
                      },
                      child: Obx(() {
                        return Container(
                          height: 40, width: 40,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 3,
                                  color: imgSelIndex.value == index
                                      ? AppColors.MAIN_COLOR
                                      : Colors.transparent),
                              image: DecorationImage(
                                image: AssetImage(product.imageUrl[index]),
                                fit: BoxFit.fill,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset.zero,
                                  blurRadius: 10,
                                )
                              ]),
                          // child: Image.asset(prod.imageUrl[0]),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.topRight,
                  child: Text(
                    'Price: ${product.price}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: AppColors.MAIN_COLOR),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20, top: 10),
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: AppColors.BACKGROUND_COLOR,
                    ),
                    onPressed: () {
                      cartController.addProduct(product);
                    },
                    child: const Text(
                      "Add To Cart",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppColors.MAIN_COLOR,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
