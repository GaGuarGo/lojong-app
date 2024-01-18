import 'package:flutter/material.dart';
import 'package:lojong_app/common/styles.dart';

class ShareButton extends StatelessWidget {
  ShareButton({super.key});

  final style = Styles();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double tabletWidth = 736.0;
      bool isTablet = constraints.maxWidth >= tabletWidth;

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        height: isTablet ? 36 : 26,
        child: ElevatedButton(
            onPressed: () {},
            style:
                ElevatedButton.styleFrom(backgroundColor: style.lightGrayColor),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.share,
                  size: isTablet ? 30 : 20,
                  color: style.grayColor,
                ),
                const SizedBox(width: 4),
                Text(
                  "Compartilhar",
                  style: isTablet ? style.buttonTitleTablet : style.buttonTitle,
                )
              ],
            )),
      );
    });
  }
}
