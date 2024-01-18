import 'package:flutter/material.dart';
import 'package:lojong_app/common/share_button.dart';
import 'package:lojong_app/common/styles.dart';
import 'package:lojong_app/models/video/video.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  VideoTile({super.key, required this.video});

  final style = Styles();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double tabletWidth = 736.0;
      bool isTablet = constraints.maxWidth >= tabletWidth;

      return Column(
        children: [
          Text(
            video.name!,
            textAlign: TextAlign.center,
            style: !isTablet ? style.title : style.titleTablet,
          ),
          const SizedBox(height: 8.0),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 8.0,
                      spreadRadius: 1.5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    height: isTablet ? 360 : 180,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: video.image_url!,
                      placeholder: (context, url) => Container(
                        height: 180,
                        width: !isTablet
                            ? MediaQuery.of(context).size.width
                            : MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: style.lightGrayColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.play_circle_fill_rounded,
                color: Theme.of(context).primaryColor,
                size: 45,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(video.description!,
              textAlign: TextAlign.center,
              style: !isTablet ? style.subtTitle : style.subtTitleTablet),
          ShareButton(),
          Divider(
            color: style.dividerColor,
            thickness: 0.2,
          ),
        ],
      );
    });
  }
}
