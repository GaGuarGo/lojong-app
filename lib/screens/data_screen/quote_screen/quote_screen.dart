import 'package:flutter/material.dart';
import 'package:lojong_app/common/styles.dart';
import 'package:lojong_app/models/network/networkManager.dart';
import 'package:lojong_app/models/quotes/quoteManager.dart';
import 'package:lojong_app/screens/data_screen/quote_screen/quote_components/loading_quote_tile.dart';
import 'package:lojong_app/screens/data_screen/quote_screen/quote_components/quote_tile.dart';
import 'package:lojong_app/screens/home_screen/components/connection_screen.dart';
import 'package:provider/provider.dart';

class QuoteScreen extends StatelessWidget {
  final NetworkManager networkManager;
  QuoteScreen({super.key, required this.networkManager});

  final style = Styles();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double tabletWidth = 736.0;
      bool isTablet = constraints.maxWidth >= tabletWidth;
      return Consumer<QuoteManager>(builder: (_, quoteManager, __) {
        if (quoteManager.isloading == true) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: List.generate(8, (index) => const LoadingQuoteTile()),
          );
        } else {
          if (quoteManager.allQuotes.isEmpty && !networkManager.isConnected) {
            return NoConnectionScreen();
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: quoteManager.allQuotes.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index < quoteManager.allQuotes.length) {
                  LinearGradient gradient;
                  TextStyle authorTextStyle;
                  TextStyle quoteTextStyle;
                  Color buttonColor;
                  if (index % 3 == 0) {
                    gradient = style.blueGradient;
                    authorTextStyle = isTablet
                        ? style.blueAuthorTitleTablet
                        : style.blueAuthorTitle;
                    quoteTextStyle = style.blueQuoteTextStyle;
                    buttonColor = style.blueCardTextColor;
                  } else if (index % 3 == 1) {
                    gradient = style.yellowGradient;
                    authorTextStyle = isTablet
                        ? style.yellowAuthorTitleTablet
                        : style.yellowAuthorTitle;
                    quoteTextStyle = style.yellowQuoteTextStyle;
                    buttonColor = style.yellowCardTextColor;
                  } else {
                    gradient = style.pinkGradient;
                    authorTextStyle = isTablet
                        ? style.redAuthorTitleTablet
                        : style.redAuthorTitle;
                    quoteTextStyle = style.redQuoteTextStyle;
                    buttonColor = style.redCardTextColor;
                  }

                  return QuoteTile(
                    isTablet: isTablet,
                    quote: quoteManager.allQuotes[index],
                    gradient: gradient,
                    authorTextStyle: authorTextStyle,
                    quoteTextStyle: quoteTextStyle,
                    buttonColor: buttonColor,
                  );
                } else if (quoteManager.moreIsLoading == false) {
                  return Builder(
                    builder: (context) {
                      quoteManager.loadMoreQuotes();
                      return Container();
                    },
                  );
                } else {
                  return Container();
                }
              },
            );
          }
        }
      });
    });
  }
}
