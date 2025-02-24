
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoApp extends StatefulWidget {
  String url;

  VideoApp({required this.url});


@override
_VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late ChewieController _controller1;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        widget.url))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller1=ChewieController(videoPlayerController: _controller,aspectRatio:16 / 9 );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {

              await launch(widget.url.toString());






          }, icon: Icon(Icons.download)),
          IconButton(onPressed: () async {
            Share.share(widget.url);
            // await launch(url.toString());






          }, icon: Icon(Icons.share))
        ],

      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Chewie(controller: _controller1,),
        )
            : Container(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class OpenImage extends StatelessWidget {
  String url;

  OpenImage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(  appBar: AppBar(
      actions: [
        IconButton(onPressed: () async {

          await launch(url.toString());






        }, icon: Icon(Icons.download)),
        IconButton(onPressed: () async {
          Share.share(url);
          // await launch(url.toString());






        }, icon: Icon(Icons.share))
      ],

    ),
    body: Container(height: double.infinity,width: double.infinity,child:Image.network(
        url) ),
    );
  }
}




