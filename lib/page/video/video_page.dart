import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // 使用缓存
  List<dynamic> videoData = [];
  final Map<int, VideoController> _videoControllers = {};
  int _currentIndex = 0;
  int _totalCount = 0;

  @override
  void initState() {
    videoData = [
      {
        "id": 1,
        "url": "https://www.w3schools.com/html/mov_bbb.mp4",
      },
      {
        "id": 2,
        "url": "https://www.w3schools.com/html/mov_bbb.mp4",
      },
      {
        "id": 3,
        "url": "https://www.w3schools.com/html/mov_bbb.mp4",
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                  future: _initVideoController(videoData[index]),
                  builder: (BuildContext context, AsyncSnapshot<VideoController> snapshot) {
                    if (snapshot.hasData) {
                      return Video(controller: snapshot.data!);
                    } else {
                      return Container();
                    }
                  },
                );
              },
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Previous")),
                ElevatedButton(onPressed: () {}, child: Text("Next")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<VideoController> _initVideoController(dynamic data) async {
    // 是否有缓存
    if (!_videoControllers.containsKey(data["id"])) {
      final Player player = Player();
      final VideoController controller = VideoController(player);
      await player.open(Media("${data["url"]}"));
      _videoControllers[data["id"]] = controller;
    }
    return _videoControllers[data["id"]]!;
  }
}
