import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerPage extends StatefulWidget {
  final String videoId = 'agv-LsgCM5U';
  const YoutubePlayerPage({super.key});

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  late YoutubePlayerController controller;

  void _onPlayerStateChange() {
    if (controller.value.playerState == PlayerState.playing) ;
  }

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        loop: false,
        autoPlay: true,
      ),
    )..addListener((_onPlayerStateChange));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        YoutubePlayer(controller: controller),
        Divider(
            indent: 50,
            endIndent: 50,
            color: Theme.of(context).colorScheme.tertiary),
        Text(
          'Hướng dẫn sử dụng',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ],
    );
  }
}
