import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lojong_app/common/styles.dart';
import 'package:lojong_app/models/quotes/quote.dart';

class QuoteTile extends StatelessWidget {
  final bool isTablet;
  final LinearGradient gradient;
  final TextStyle authorTextStyle;
  final TextStyle quoteTextStyle;
  final Color buttonColor;
  final Quote quote;
  QuoteTile(
      {super.key,
      required this.quote,
      required this.gradient,
      required this.authorTextStyle,
      required this.quoteTextStyle,
      required this.buttonColor,
      required this.isTablet});

  final style = Styles();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 2.0),
          blurRadius: 8.0,
          spreadRadius: 1.5,
        ),
      ], borderRadius: BorderRadius.circular(16), gradient: gradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: !isTablet
                ? MediaQuery.of(context).size.height * 0.305
                : MediaQuery.of(context).size.height * 0.36,
            child: AutoSizeText(
              quote.text!,
              minFontSize: isTablet ? 26 : 12,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: quoteTextStyle,
            ),
          ),
          const SizedBox(height: 16.0),
          AutoSizeText(
            quote.author!,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: authorTextStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0, bottom: 0),
            height: isTablet ? 36 : 26,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.share,
                        size: isTablet ? 30 : 20,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Compartilhar",
                        style: !isTablet
                            ? style.quoteButtonTitle
                            : style.quoteButtonTitleTablet,
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
