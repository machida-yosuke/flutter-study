import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFirestorePage extends StatefulWidget {
  MyFirestorePage({Key key}) : super(key: key);

  @override
  _MyFirestorePageState createState() => _MyFirestorePageState();
}

class _MyFirestorePageState extends State<MyFirestorePage> {
  List<DocumentSnapshot> documentList = [];

  String orderDocumentInfo = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('id_abc')
                    .set({'name': '鈴木', 'age': 40});
              },
              child: Text('コレクション＋ドキュメント作成'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('id_abc')
                    .collection('orders')
                    .doc('id_123')
                    .set({'price': 600, 'date': '4 / 11'});
              },
              child: Text('コレクション＋ドキュメント作成'),
            ),
            ElevatedButton(
              onPressed: () async {
                final QuerySnapshot snapshot =
                    await FirebaseFirestore.instance.collection('users').get();
                setState(() {
                  documentList = snapshot.docs;
                });
              },
              child: Text('ドキュメント一覧取得'),
            ),
            Column(
              children: documentList.map((document) {
                return ListTile(
                  title: Text('${document['name']}さん'),
                  subtitle: Text('${document['age']}歳'),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                final DocumentSnapshot snapshot = await FirebaseFirestore
                    .instance
                    .collection('users')
                    .doc('id_abc')
                    .collection('orders')
                    .doc('id_123')
                    .get();
                setState(() {
                  orderDocumentInfo =
                      '${snapshot['date']}${snapshot['price']}円';
                });
              },
              child: Text('ドキュメントを指定して取得'),
            ),
            ListTile(title: Text(orderDocumentInfo)),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('id_abc')
                    .update({'age': 10});
              },
              child: Text('ドキュメント更新'),
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc('id_abc')
                      .collection('orders')
                      .doc('id_123')
                      .delete();
                },
                child: Text('ドキュメント更新'))
          ],
        ),
      ),
    );
  }
}
