import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onlineshopui/constants.dart';
import 'package:onlineshopui/models/Product.dart';
import 'package:onlineshopui/screen/details/components/counter_with_fav_btn.dart';
import 'package:onlineshopui/screen/details/components/product_title_with_image.dart';

import 'add_to_cart.dart';
import 'color_and_size.dart';
import 'description.dart';

class Body extends StatelessWidget {
  final Product product;
  const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //端末縦サイズを超えたら自動でスクロールするようにする
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: kDefaulPaddin,
                    right: kDefaulPaddin,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)),
                  ),
                  child: Column(
                    children: [
                      ColorAndSize(product: product),
                      SizedBox(height: kDefaulPaddin / 2),
                      Description(product: product),
                      SizedBox(height: kDefaulPaddin / 2),
                      CounterWithFavBtn(),
                      SizedBox(height: kDefaulPaddin / 2),
                      AddToCart(product: product)
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
