import 'package:flutter/material.dart';
import 'package:onlineshopui/constants.dart';
import 'package:onlineshopui/models/Product.dart';
import 'package:onlineshopui/screen/details/details_screen.dart';
import 'package:onlineshopui/screen/home/components/Item_card.dart';
import 'package:onlineshopui/screen/home/components/categories.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //https://qiita.com/kaleidot725/items/35f6940e594bdf073eb8
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          // symmetric 上下左右 horizontal vertical
          padding: const EdgeInsets.symmetric(horizontal: kDefaulPaddin),
          child: Text("Woman",
              //htmlでいうhタグのスタイル
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        Categories(),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaulPaddin),
          child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: kDefaulPaddin,
                  mainAxisSpacing: kDefaulPaddin),
              itemBuilder: (context, index) => ItemCard(
                    product: products[index],
                    press: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: products[index],
                            ),
                          ))
                    },
                  )),
        ))
      ],
    );
  }
}
