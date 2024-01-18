import 'package:flutter/material.dart';
import 'package:lojong_app/common/styles.dart';
import 'package:lojong_app/models/network/networkManager.dart';
import 'package:lojong_app/screens/data_screen/article_screen/article_screen.dart';
import 'package:lojong_app/screens/data_screen/quote_screen/quote_screen.dart';
import 'package:lojong_app/screens/data_screen/video_screen/video_screen.dart';
import 'package:provider/provider.dart';

class DataScreen extends StatelessWidget {
  final String option;
  DataScreen({super.key, required this.option});

  final style = Styles();

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkManager>(
      builder: (_, networkManager, __) {
        switch (option) {
          case 'Videos':
            return VideoScreen(networkManager: networkManager);
          case 'Articles':
            return ArticleScreen(networkManager: networkManager);
          case 'Quotes':
            return QuoteScreen(networkManager: networkManager);
          default:
            return Container();
        }
      },
    );
  }
}
