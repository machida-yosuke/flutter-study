import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pthoto_app/app_state.dart';
import 'package:pthoto_app/photo.dart';
import 'package:pthoto_app/photo_view_screen.dart';
import 'package:pthoto_app/sign_in_screen.dart';
import 'package:provider/provider.dart';

class PhotoListScreen extends StatefulWidget {
  PhotoListScreen({Key key}) : super(key: key);

  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  int _currentIndex;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final AppState appState = context.watch<AppState>();
    final List<Photo> photoList = appState.photoList;
    final List<Photo> favoritePhotoList = appState.getFavoritePhotoList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Photo App'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => _onSignOut(context)),
        ],
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (int index) => _onPageChanged(index),
        children: [
          PhotoGridView(
            photoList: photoList,
            onTap: (photo) => _onTapPhoto(context, photo),
            onTapFav: (photo) => _onTapFav(photo),
          ),
          PhotoGridView(
            photoList: favoritePhotoList,
            onTap: (photo) => _onTapPhoto(context, photo),
            onTapFav: (photo) => _onTapFav(photo),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddPhoto(),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => _onTapBottomNavigationItem(index),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'フォト'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'お気に⼊り')
        ],
      ),
    );
  }

  Future<void> _onSignOut(BuildContext context) async {
    final AppState appState = context.read<AppState>();
    await appState.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => SignInScreen()));
  }

  Future<void> _onAddPhoto() async {
    final FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path);
      final AppState appState = context.read<AppState>();
      await appState.addPhoto(file);
    }
  }

  void _onTapPhoto(
    BuildContext context,
    Photo photo,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        // 処理を⾏う際はモデルを受け渡す
        builder: (_) => PhotoViewScreen(
          photo: photo,
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTapBottomNavigationItem(int index) {
    _controller.animateToPage(index,
        duration: Duration(microseconds: 300), curve: Curves.easeOut);
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTapFav(Photo photo) {
    final AppState appState = context.read();
    appState.toggleFavorite(photo);
  }
}

class PhotoGridView extends StatelessWidget {
  const PhotoGridView({
    Key key,
    @required this.photoList,
    @required this.onTap,
    @required this.onTapFav,
  }) : super(key: key);
  final List<Photo> photoList;
  final Function(Photo photo) onTap;
  final Function(Photo photo) onTapFav;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      children: photoList.map((Photo photo) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: InkWell(
                onTap: () => _onTapPhoto(
                  context,
                  photo,
                ),
                child: Image.network(
                  photo.imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => {_onTapFav(context, photo)},
                color: Colors.white,
                icon: photo.isFavorite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
              ),
            )
          ],
        );
      }).toList(),
    );
  }

  void _onTapFav(BuildContext context, Photo photo) {
    final AppState appState = context.read();
    appState.toggleFavorite(photo);
  }

  void _onTapPhoto(BuildContext context, Photo photo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PhotoViewScreen(
          photo: photo,
        ),
      ),
    );
  }
}
