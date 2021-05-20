/* 4-3. Drawer */

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => MainPage(),
        '/sub': (BuildContext context) => SubPage(),
        '/sub2': (BuildContext context) => Sub2Page(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mainページ'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Main"),
              TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/sub'),
                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  child: Text(
                    'sub1へ',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sub1ページ'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("sub1"),
              TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/sub2'),
                  style: TextButton.styleFrom(backgroundColor: Colors.grey),
                  child: Text(
                    'sub2へ',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class Sub2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sub2ページ'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("sub2"),
            ],
          ),
        ),
      ),
    );
  }
}
