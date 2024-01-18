import 'package:flutter/material.dart';
import 'package:lojong_app/common/styles.dart';

class LoadingVideoTile extends StatelessWidget {
  LoadingVideoTile({super.key});

  final style = Styles();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double tabletWidth = 736.0;
      bool isTablet = constraints.maxWidth >= tabletWidth;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            _blankContainer(context, height: 40),
            _blankContainer(context, height: isTablet ? 320 : 160),
            _blankContainer(context, height: 40),
            _blankContainer(context, height: 30, width: 120),
            Divider(
              color: style.dividerColor,
              thickness: 0.2,
            ),
          ],
        ),
      );
    });
  }

  Widget _blankContainer(BuildContext context,
          {required double height, double? width}) =>
      Container(
        decoration: BoxDecoration(
            color: style.lightGrayColor,
            borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        height: height,
        width: width ?? MediaQuery.of(context).size.width,
      );
}
