import 'dart:io';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'smile sns',
      theme: ThemeData(
          primarySwatch: Colors.blue,

          // VisualDensity により視覚的な詰まり具合(密度)を調整します。
          // デスクトッププラットフォームの場合はコントロールが小さくなり、
          // モバイルプラットフォームより密度が高くなります。、
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MainForm(),
    );
  }
}

class MainForm extends StatefulWidget {
  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  String _name = '';
  String _processingMessage = '';

  final FaceDetector _faceDetector =
      FirebaseVision.instance.faceDetector(FaceDetectorOptions(
          //顔検出を実行する際の追加のトレードオフを制御するためのオプション。正確な場合、より多くの面を検出する傾向があり、速度を犠牲にして、位置などの値をより正確に決定できる場合があります。
          //accurate = 正確 時間かかるけど正確
          mode: FaceDetectorMode.accurate,
          //顔のランドマークを表します。
          enableLandmarks: true,
          //属性を特徴付けるために追加の分類子を実行するかどうか。 例：「笑顔」と「目を開ける」。
          enableClassification: true));

  final ImagePicker _picker = ImagePicker();

  Face findLargestFace(List<Face> faces) {
    Face largestFace = faces[0];

    for (Face face in faces) {
      if (face.boundingBox.height + face.boundingBox.width >
          largestFace.boundingBox.height + largestFace.boundingBox.width) {
        largestFace = face;
      }
    }
    return largestFace;
  }

  void _getImageAndFindFace(
      BuildContext context, ImageSource imageSource) async {
    final PickedFile pickedFile = await _picker.getImage(source: imageSource);
    final File file = File(pickedFile.path);

    setState(() {
      _processingMessage = 'Processing...';
    });

    // 画像取得できたら
    if (file != null) {
      final FirebaseVisionImage visionImage =
          FirebaseVisionImage.fromFile(file);
      List<Face> faces = await _faceDetector.processImage(visionImage);

      if (faces.length > 0) {
        String imagePath = 'image/${Uuid().v1()}${basename(pickedFile.path)}';
        Reference ref = FirebaseStorage.instance.ref('/').child(imagePath);
        final UploadTask uploadTask = ref.putFile(file);
        String imageUrl = await (await uploadTask).ref.getDownloadURL();
        print(imageUrl);
        print('---------');
        Face largestFace = findLargestFace(faces);

        FirebaseFirestore.instance.collection('smiles').add({
          'name': _name,
          // 一番でかい顔の笑顔レベル
          'smile_prob': largestFace.smilingProbability,
          'image_url': imageUrl,
          'date': Timestamp.now()
        });

        print('Navigator');
        print('---------');

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimelinePage(),
            ));
      }

      setState(() {
        _processingMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('smail sns'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(30)),
          Text(
            _processingMessage,
            style: TextStyle(color: Colors.lightBlue, fontSize: 32),
          ),
          TextField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: "Please input your name.",
              labelText: "YOUR NAME",
            ),
            onChanged: (text) {
              setState(() {
                _name = text;
              });
            },
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _getImageAndFindFace(context, ImageSource.gallery);
            },
            tooltip: 'select image',
            heroTag: 'gallery',
            child: Icon(Icons.add_photo_alternate),
          ),
          Padding(padding: EdgeInsets.all(10)),
          FloatingActionButton(
            onPressed: () {
              _getImageAndFindFace(context, ImageSource.camera);
            },
            tooltip: "Take Photo",
            heroTag: "camera",
            child: Icon(Icons.add_a_photo),
          )
        ],
      ),
    );
  }
}

class TimelinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMILE SNS'),
      ),
      body: Container(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('smiles')
            .orderBy('date', descending: true)
            .limit(10)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.docs);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapList) {
    return ListView.builder(
      padding: const EdgeInsets.all(18),
      itemCount: snapList.length,
      itemBuilder: (context, i) {
        return _buildListItem(context, snapList[i]);
      },
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snap) {
    Map<String, dynamic> _data = snap.data();
    DateTime _datetime = _data['date'].toDate();
    var _formatter = DateFormat("MM/dd HH:mm");
    String postDate = _formatter.format(_datetime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          leading: Text(postDate),
          title: Text(_data['name']),
          subtitle: Text("は" +
              (_data["smile_prob"] * 100.0).toStringAsFixed(1) +
              "%の笑顔です。"),
          trailing: Text(
            _getIcon(_data['smile_prob']),
            style: TextStyle(fontSize: 24),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImagePage(_data['image_url'])));
          },
        ),
      ),
    );
  }

  String _getIcon(double smileProb) {
    String icon = '';
    if (smileProb < 0.2) {
      icon = "😧";
    } else if (smileProb < 0.4) {
      icon = "😌";
    } else if (smileProb < 0.6) {
      icon = "😀";
    } else if (smileProb < 0.8) {
      icon = "😄";
    } else {
      icon = "😆";
    }
    return icon;
  }
}

// ignore: must_be_immutable
class ImagePage extends StatelessWidget {
  String _imageUrl = '';
  ImagePage(String imageUrl) {
    _imageUrl = imageUrl;
    print(imageUrl);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMILE SNS"),
      ),
      body: Center(
        child: Image.network(_imageUrl),
      ),
    );
  }
}
