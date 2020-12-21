import 'package:flutter/material.dart';
import 'package:yoyo_player/yoyo_player.dart';
import 'package:Juhuischool/screens/prizedetail.dart';
import 'package:Juhuischool/screens/Coursedetail.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

_onBasicBotAlertPressed(context,fullname,password) {
  Alert(
    context: context,
    title: fullname,
    desc: password,
  ).show();
}

class showaudio extends StatefulWidget {
  @override
  _showaudioState createState() => _showaudioState();
}


class _showaudioState extends State<showaudio> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            AudioApp(),
            _getContent(),
            _showprofile(),
          ],
        ),
      ),
    );
  }
}

class AudioApp extends StatefulWidget {
  @override
  _AudioAppState createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audio App',
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            YoYoPlayer(
              aspectRatio: 9 / 17,
              url:
                //   "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                  "https://class.yixinacademy.com/assets/audios/course/${videolist[video_num]}",
              // "https://player.vimeo.com/external/440218055.m3u8?s=7ec886b4db9c3a52e0e7f5f917ba7287685ef67f&oauth2_token_id=1360367101",
              // "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
              videoStyle: VideoStyle(),
              videoLoadingStyle: VideoLoadingStyle(
                loading: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.fitHeight,
                        height: 50,
                      ),
                      Text("Loading video"),
                    ],
                  ),
                ),
              ),
              onfullscreen: (t) {
                if(mounted) {
                  setState(() {
                    fullscreen_a++;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class showvideo extends StatefulWidget {
  @override
  _showvideoState createState() => _showvideoState();
}

class _showvideoState extends State<showvideo> {
  
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            VideoApp(),
            _getContent(),
            _showprofile(),
          ],
        ),
      ),
    );
  }
}
_getContent() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          SizedBox(
            height: 50.0,
            child: TyperAnimatedTextKit(
                text: [titlelist[video_num],titlelist[video_num],],
                textStyle: TextStyle(color: Colors.white24, fontSize: 25),
            ),
          ),
        ],
      ),
    ],
  );
}
_showprofile() {
  var now = new DateTime.now();
  /*
  if(fullscreen_v % 2 == 0)
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        Text(
          "username : ${user_email}\n${now}\n\n\n\n\n\n\n\n\n\n\n\n",
          style: TextStyle(color: Colors.white24, fontSize: 20),
        ),
      ],
    );
  else 
  */
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        Text(
          "username : ${user_email}\n${now}\n",
          style: TextStyle(color: Colors.white24, fontSize: 20),
        ),
      ],
    );
}
class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}
class _VideoAppState extends State<VideoApp> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video App',
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            YoYoPlayer(
              aspectRatio: 9 / 17,
              url:
                //   "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                  "https://class.yixinacademy.com/assets/videos/course/${videolist[video_num]}",
              // "https://player.vimeo.com/external/440218055.m3u8?s=7ec886b4db9c3a52e0e7f5f917ba7287685ef67f&oauth2_token_id=1360367101",
              // "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
              videoStyle: VideoStyle(),
              videoLoadingStyle: VideoLoadingStyle(
                loading: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.fitHeight,
                        height: 50,
                      ),
                      Text("Loading video"),
                    ],
                  ),
                ),
              ),
              onfullscreen: (t) {
                setState(() {
                  fullscreen_v++;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}