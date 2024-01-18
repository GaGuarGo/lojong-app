import 'package:flutter/material.dart';
import 'package:lojong_app/models/network/networkManager.dart';
import 'package:lojong_app/models/video/videoManager.dart';
import 'package:lojong_app/screens/data_screen/video_screen/video_components/loading_tile.dart';
import 'package:lojong_app/screens/data_screen/video_screen/video_components/video_tile.dart';
import 'package:lojong_app/screens/home_screen/components/connection_screen.dart';
import 'package:provider/provider.dart';

class VideoScreen extends StatelessWidget {
  final NetworkManager networkManager;
  const VideoScreen({super.key, required this.networkManager});

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoManager>(builder: (_, videoManager, __) {
      if (videoManager.isloading == true) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: List.generate(8, (index) => LoadingVideoTile()),
        );
        // return NoConnectionScreen();
      } else {
        if (videoManager.allVideos.isEmpty && !networkManager.isConnected) {
          return NoConnectionScreen();
        } else {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: videoManager.allVideos
                .map((video) => VideoTile(video: video))
                .toList(),
          );
        }
      }
    });
  }
}
