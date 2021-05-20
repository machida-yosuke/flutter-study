import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:qiitaapp/qiita_repository.dart';
import 'package:qiitaapp/screens/item_list_screen.dart';
import 'package:qiitaapp/screens/sign_in/sign_in_screen.dart';

void main() async {
  Intl.defaultLocale = 'ja_JP';
  await initializeDateFormatting('ja_JP');
  runApp(QiitaApp());
}

class QiitaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _LoadAccessToken(),
    );
  }
}

class _LoadAccessToken extends StatefulWidget {
  _LoadAccessToken({Key key}) : super(key: key);

  @override
  __LoadAccessTokenState createState() => __LoadAccessTokenState();
}

class __LoadAccessTokenState extends State<_LoadAccessToken> {
  Error _error;

  @override
  void initState() {
    super.initState();
    Future(() async {
      try {
        final isSave = await QiitaReposity().accessTokenIsSaved();
        if (isSave) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => ItemListScreen()));
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => SignInScreen()),
          );
        }
      } catch (e) {
        setState(() {
          _error = e;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: (_error == null
            ? CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Text(_error.toString())),
      ),
    );
  }
}
