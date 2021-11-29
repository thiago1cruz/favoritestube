import 'package:favoritestube/api.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final String idVideo;
  const VideoPage({Key? key, required this.idVideo}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState(idVideo);
}

class _VideoPageState extends State<VideoPage> {
  final String idVideo;
  late YoutubePlayerController _controller;

  _VideoPageState(this.idVideo);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.idVideo, //Add videoID.
      flags: const YoutubePlayerFlags(
        hideControls: false,
        controlsVisibleAtStart: true,
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: YoutubePlayer(
        key: const Key(API_KEY),
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {},
      ),
    );
  }
}
