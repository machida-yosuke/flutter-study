import 'package:flutter/material.dart';
import 'package:pthoto_app/app_state.dart';
import 'package:pthoto_app/photo_list_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Photo App',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'メールアドレス',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) return 'メールアドレスを⼊⼒して下さい';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'パスワード',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value.isEmpty) return 'パスワードを⼊⼒して下さい';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => _onSignIn(context),
                      child: Text('ログイン'),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => _onSignUp(context),
                      child: Text('新規登録'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSignIn(BuildContext context) async {
    try {
      if (_formKey.currentState.validate() == false) {
        return;
      }
      final String email = _emailController.text;
      final String password = _passwordController.text;

      final AppState appState = context.read<AppState>();
      await appState.signIn(email: email, password: password);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => PhotoListScreen(),
        ),
      );
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('エラー'),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  Future<void> _onSignUp(BuildContext context) async {
    try {
      if (_formKey.currentState.validate() == false) {
        return;
      }

      final String email = _emailController.text;
      final String password = _passwordController.text;
      final AppState appState = context.read<AppState>();
      await appState.signUp(email: email, password: password);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => PhotoListScreen(),
        ),
      );
    } catch (e) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('エラー'),
              content: Text(e.toString()),
            );
          });
    }
  }
}
