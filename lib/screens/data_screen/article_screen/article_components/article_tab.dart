import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lojong_app/common/styles.dart';
import 'package:lojong_app/models/articles/articleManager.dart';
import 'package:lojong_app/screens/data_screen/article_screen/article_components/author_card.dart';
import 'package:lojong_app/screens/data_screen/article_screen/article_components/connection_article.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class ArticleTab extends StatelessWidget {
  final bool isTablet;
  final int aid;
  ArticleTab({super.key, required this.aid, required this.isTablet});

  final style = Styles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColorDark),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              )),
          title: const Text(
            "INSPIRAÇÕES",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: "Asap"),
          ),
        ),
        body: Consumer<ArticleManager>(
          builder: (_, articleManager, __) {
            if (articleManager.selectedArtile == null) {
              return Center(
                  child: NoConnectionArticle(
                aid: aid,
              ));
            } else if (articleManager.contentLoading == true) {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor)));
            } else {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: SizedBox(
                      height: isTablet ? 360 : 180,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: articleManager.selectedArtile!.image_url!,
                        placeholder: (context, url) => Container(
                          height: isTablet ? 360 : 180,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: style.lightGrayColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      articleManager.selectedArtile!.title!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 2.0,
                          fontFamily: 'Asap',
                          fontWeight: FontWeight.w700,
                          fontSize: isTablet ? 22 : 16,
                          color: const Color(0xFF80848F)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Html(
                      data: articleManager.selectedArtile!.full_text,
                      style: {
                        "a": Style(
                            color: Theme.of(context).primaryColor,
                            textDecoration: TextDecoration.none),
                        "p": isTablet
                            ? Style(fontSize: FontSize.larger)
                            : Style(),
                        "em": isTablet
                            ? Style(fontSize: FontSize.large)
                            : Style(),
                      },
                    ),
                  ),
                  AuthorCard(article: articleManager.selectedArtile!),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: () {},
                        child: const Text(
                          "COMPARTILHAR",
                          style: TextStyle(
                              fontFamily: 'Asap',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 16),
                        )),
                  )
                ],
              );
            }
          },
        ));
  }
}
