

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoDetailsPage extends StatefulWidget {
  const VideoDetailsPage({super.key});

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {

  Player player = Player();
  late VideoController controller = VideoController(player);

  @override
  void initState() {

    player.open(Media("url"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [

            AspectRatio(aspectRatio: 6/16,
            child: Video(controller: controller),
            ),


          ],
        ),
      ),
    );
  }
}
