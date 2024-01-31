import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toolkit/page/video/video_cubit.dart';
// import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoCubit? videoCubit;
  // List<VideoPlayerController> _listController = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for (int i = 0; i < 10; i++) {
        // _listController.add(VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
        //   ..initialize().then((_) {
        //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        //     setState(() {});
        //   }));
      }
    });


    scrollController.addListener(() {

      int index = (scrollController.offset/200).floor();

      print("${scrollController.offset}  偏移的数据");
      // for (var i = 0; i < _listController.length; i++) {
      //   if (i == index) {
      //     _listController[i].play();
      //   } else {
      //     _listController[i].pause();
      //   }
      // }
    });


  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoCubit>(
      create: (BuildContext context) => VideoCubit(),
      child: BlocBuilder<VideoCubit, VideoState>(builder: (BuildContext context, state) {
        videoCubit = context.read<VideoCubit>();

        return Scaffold(
          appBar: AppBar(
            title: Text("视频"),
          ),
          body: ListView.builder(
            controller: scrollController,
            // itemCount: _listController.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  color: Colors.red,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        // child: VideoPlayer(_listController[index]),
                      ),
                      TextButton(
                          onPressed: () {
                            // VideoPlayerController controller = _listController[index];
                            // controller.value.isPlaying ? controller.pause() : controller.play();
                            // _listController[index].play();
                          },
                          child: Text("播放")),
                    ],
                  ));
            },
          ),
        );
      }),
    );
  }
}
