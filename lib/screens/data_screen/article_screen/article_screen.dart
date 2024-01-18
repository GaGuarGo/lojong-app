import 'package:flutter/material.dart';
import 'package:lojong_app/models/articles/articleManager.dart';
import 'package:lojong_app/models/network/networkManager.dart';
import 'package:lojong_app/screens/data_screen/article_screen/article_components/article_tile.dart';
import 'package:lojong_app/screens/data_screen/video_screen/video_components/loading_tile.dart';
import 'package:lojong_app/screens/home_screen/components/connection_screen.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatelessWidget {
  final NetworkManager networkManager;
  const ArticleScreen({super.key, required this.networkManager});

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleManager>(builder: (_, articleManager, __) {
      if (articleManager.isloading == true) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: List.generate(8, (index) => LoadingVideoTile()),
        );
      } else {
        if (articleManager.allArticles.isEmpty && !networkManager.isConnected) {
          return NoConnectionScreen();
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: articleManager.allArticles.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < articleManager.allArticles.length) {
                return ArticleTile(
                  article: articleManager.allArticles[index],
                );
              } else if (articleManager.moreIsLoading == false) {
                articleManager.loadMoreArticles();
                return Container();
              }
              return Container();
            },
          );
        }
      }
    });
  }
}
