import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: AudioPlayerPage(),
      ),
    );
  }
}

class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/audio.mp3');
    _controller.initialize().then((_) {
      // 最初のフレームを描画するため初期化後に更新
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Icon(Icons.music_video, size: 256),
          ),
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
          ),
          _ProgressText(controller: _controller),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  _controller
                      .seekTo(Duration.zero)
                      .then((_) => _controller.play());
                },
                icon: Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: () {
                  _controller.play();
                },
                icon: Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: () {
                  _controller.pause();
                },
                icon: Icon(Icons.pause),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressText extends StatefulWidget {
  final VideoPlayerController controller;

  const _ProgressText({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  __ProgressTextState createState() => __ProgressTextState();
}

class __ProgressTextState extends State<_ProgressText> {
  VoidCallback _listener;

  __ProgressTextState() {
    _listener = () {
      setState(() {});
    };
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  @override
  void deactivate() {
    widget.controller.removeListener(_listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final String position = widget.controller.value.position.toString();
    final String duration = widget.controller.value.duration.toString();
    return Text('$position / $duration');
  }
}

// class VideoPlayerPage extends StatefulWidget {
//   @override
//   _VideoPlayerPageState createState() => _VideoPlayerPageState();
// }

// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('assets/video.mp4');
//     _controller.initialize().then((_) {
//       // 最初のフレームを描画するため初期化後に更新
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           ),
//           VideoProgressIndicator(
//             _controller,
//             allowScrubbing: true,
//           ),
//           _ProgressText(controller: _controller),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   _controller
//                       .seekTo(Duration.zero)
//                       .then((_) => _controller.play());
//                 },
//                 icon: Icon(Icons.refresh),
//               ),
//               IconButton(
//                 onPressed: () {
//                   _controller.play();
//                 },
//                 icon: Icon(Icons.play_arrow),
//               ),
//               IconButton(
//                 onPressed: () {
//                   _controller.pause();
//                 },
//                 icon: Icon(Icons.pause),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ProgressText extends StatefulWidget {
//   final VideoPlayerController controller;

//   const _ProgressText({
//     Key key,
//     this.controller,
//   }) : super(key: key);

//   @override
//   __ProgressTextState createState() => __ProgressTextState();
// }

// class __ProgressTextState extends State<_ProgressText> {
//   VoidCallback _listener;

//   __ProgressTextState() {
//     _listener = () {
//       setState(() {});
//     };
//   }

//   @override
//   void initState() {
//     super.initState();
//     widget.controller.addListener(_listener);
//   }

//   @override
//   void deactivate() {
//     widget.controller.removeListener(_listener);
//     super.deactivate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String position = widget.controller.value.position.toString();
//     final String duration = widget.controller.value.duration.toString();
//     return Text('$position / $duration');
//   }
// }
