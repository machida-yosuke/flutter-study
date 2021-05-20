import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pthoto_app/app_state.dart';
import 'package:pthoto_app/photo_list_screen.dart';
import 'package:pthoto_app/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
          )),
        ),
        home: Builder(
          builder: (context) {
            final appState = context.watch<AppState>();
            if (appState.user == null) {
              return SignInScreen();
            }
            return PhotoListScreen();
          },
        ),
      ),
    );
  }
}
