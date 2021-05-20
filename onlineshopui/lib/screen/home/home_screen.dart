import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onlineshopui/constants.dart';
import 'package:onlineshopui/screen/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Cmd+.(Mac)でUIのコードを分離できる
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      // 標高 つまり高さを０にして影を消す
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('assets/icons/back.svg'),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            'assets/icons/search.svg',
            // svgの色を変える　defaultは白
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            'assets/icons/cart.svg',
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        SizedBox(
          width: kDefaulPaddin / 2,
        )
      ],
    );
  }
}
