import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAudioPlayer extends StatefulWidget {
 String url_ad;
 CustomAudioPlayer(this.url_ad);


  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  final player = AudioPlayer();
  bool isPlaying=false;
  Duration duration=Duration.zero;
  Duration position=Duration.zero;
  @override
  void initState() {
    super.initState();
   player.onPlayerStateChanged.listen((event) {
     setState(() {
       isPlaying=event==PlayerState.playing;
     });
   });

   player.onDurationChanged.listen((event) {

     setState(() {
       duration=event;
     });
   });


   player.onPositionChanged.listen((event) {
     position=event;
   });

  }
   Future <void> playAudioFromUrl(String url) async {
    await player.play(UrlSource(url));
  }
  @override
  void dispose() {
     player.dispose();

    // TODO: implement dispose
    super.dispose();
  }
  String formatTime(Duration duration)
  {
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final h=twoDigits(duration.inHours);
    final m=twoDigits(duration.inMinutes.remainder(60));
    final s=twoDigits(duration.inSeconds.remainder(60));
    return[
      if (duration.inHours>0) h,
      m,s,
    ].join(':');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(  appBar: AppBar(
      actions: [
        IconButton(onPressed: () async {

          await launch(widget.url_ad.toString());






        }, icon: Icon(Icons.download)),
        IconButton(onPressed: () async {
          Share.share(widget.url_ad);
          // await launch(url.toString());






        }, icon: Icon(Icons.share))
      ],

    ),body: Container(
        alignment: Alignment.center,
        child: Column(children: [
          SizedBox(height: 10,),
          isPlaying?CustomLotte('assets/lang/sound.json'):Image(image: AssetImage('images/wave_sound.png'),width: 100.w,height: 85.w,),
      Slider(
        min: 0,
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(), onChanged: (value) async {
            final position= Duration(seconds: value.toInt());
            await player.seek(position);
            await player.resume();
          },),
      Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(formatTime(position),),Text(formatTime(duration-position),)]),
      
      ),
      CircleAvatar(radius: 35,
      child: IconButton(onPressed: () async{
        if(isPlaying)
          {
            await player.pause();
          }
        else{
          await player.play(UrlSource(widget.url_ad));
        }

      },iconSize: 50, icon: Icon(isPlaying?Icons.pause:Icons.play_arrow))),
    //   ElevatedButton(
    //   onPressed: () {
    //     playAudioFromUrl(widget.url_ad);
    //     },
    //   child: const Text('Play Audio'),
    // ),
    //   ElevatedButton(
    //     onPressed: () async {
    //       await player.stop() ;
    //     },
    //     child: const Text('Stop Audio'),
    //   ),

    ],)),);

  }
}
