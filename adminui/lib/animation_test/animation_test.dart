import 'package:flutter/material.dart';

class AnimationTest extends StatefulWidget {
  AnimationTest({Key key}) : super(key: key);

  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  double size = 100;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween<double>(begin: 1, end: 2).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () {
                controller.forward();
              },
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: () {
                controller.stop();
              },
            ),
            IconButton(
              icon: Icon(Icons.loop),
              onPressed: () {
                controller.repeat();
              },
            ),
            IconButton(
              icon: Icon(Icons.play_arrow_outlined),
              onPressed: () {
                setState(() {
                  size = 400;
                });
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AnimatedContainer(
            duration: Duration(seconds: 1),
            width: size,
            height: 100,
            color: Colors.blue,
          ),
          ScaleTransition(
            scale: animation,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.black,
            ),
          ),
        ]),
      ),
    );
  }
}
