import 'package:flutter/material.dart';
import 'package:pthoto_app/app_state.dart';
import 'package:pthoto_app/photo.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class PhotoViewScreen extends StatefulWidget {
  const PhotoViewScreen({
    Key key,
    @required this.photo,
  }) : super(key: key);
  final Photo photo;

  @override
  _PhotoViewScreenState createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  PageController _controller;
  int _currentPage;

  @override
  void initState() {
    final AppState appState = context.read<AppState>();
    final int initialPage = appState.photoList.indexOf(widget.photo);
    _controller = PageController(
      initialPage: initialPage,
    );
    _currentPage = initialPage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppState appState = context.watch<AppState>();
    final List<Photo> photoList = appState.photoList;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (int index) => {_onPageChanged(index)},
            children: photoList.map((Photo photo) {
              return Image.network(
                photo.imageURL,
                fit: BoxFit.cover,
              );
            }).toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () => {_onTapShare(context)},
                    color: Colors.white,
                    icon: Icon(Icons.share),
                  ),
                  IconButton(
                    onPressed: () => {_onTapDelete(context)},
                    color: Colors.white,
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () => _onTapFav(context),
                    color: Colors.white,
                    icon: widget.photo.isFavorite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onTapShare(BuildContext context) async {
    print('_onTapShare');
    final AppState state = context.read<AppState>();
    final Photo photo = state.photoList[_currentPage];
    await Share.share(photo.imageURL);
  }

  Future<void> _onTapFav(BuildContext context) async {
    final AppState appState = context.read();
    final Photo photo = appState.photoList[_currentPage];
    await appState.toggleFavorite(photo);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Future<void> _onTapDelete(BuildContext context) async {
    final AppState appState = context.read<AppState>();
    final List<Photo> photoList = appState.photoList;
    final Photo photo = photoList[_currentPage];

    if (photoList.length == 1) {
      Navigator.of(context).pop();
    } else if (photoList.last == photo) {
      await _controller.previousPage(
        duration: Duration(microseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    await appState.deletePhoto(photo);
  }
}
