import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAuthPage extends StatefulWidget {
  MyAuthPage({Key key}) : super(key: key);

  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  String userMail = '';
  String userPw = '';

  String userLoginMail = '';
  String userLoginPw = '';

  String infoText = '';

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    userMail = value;
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'パスワード（６文字以上）',
                ),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    userPw = value;
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final UserCredential result =
                        await auth.createUserWithEmailAndPassword(
                            email: userMail, password: userPw);
                    final User user = result.user;
                    setState(() {
                      infoText = '登録完了 ${user.email}';
                    });
                  } catch (e) {
                    setState(() {
                      infoText = "登録NG：${e.toString()}";
                    });
                  }
                },
                child: Text('ユーザー登録'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'メールアドレス',
                ),
                onChanged: (String value) {
                  setState(() {
                    userLoginMail = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'パスワード',
                ),
                onChanged: (String value) {
                  setState(() {
                    userLoginPw = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential result =
                        await auth.signInWithEmailAndPassword(
                      email: userLoginMail,
                      password: userLoginPw,
                    );

                    final User user = result.user;
                    setState(() {
                      infoText = 'ログインOK ${user.email}';
                    });
                  } catch (e) {
                    setState(() {
                      infoText = 'ログインNG ${e.toString()}';
                    });
                  }
                },
                child: Text('ログイン'),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(infoText)
            ],
          ),
        ),
      ),
    );
  }
}
