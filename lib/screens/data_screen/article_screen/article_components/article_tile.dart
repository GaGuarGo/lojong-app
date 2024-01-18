import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lojong_app/common/share_button.dart';
import 'package:lojong_app/common/styles.dart';
import 'package:lojong_app/models/articles/article.dart';
import 'package:lojong_app/models/articles/articleManager.dart';
import 'package:lojong_app/screens/data_screen/article_screen/article_components/article_tab.dart';
import 'package:provider/provider.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  ArticleTile({super.key, required this.article});

  final style = Styles();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double tabletWidth = 736.0;
      bool isTablet = constraints.maxWidth >= tabletWidth;

      return GestureDetector(
        onTap: () {
          context.read<ArticleManager>().loadArticleContent(article.id!);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ArticleTab(
              aid: article.id!,
              isTablet: isTablet,
            );
          }));
        },
        child: Column(
          children: [
            Text(
              article.title!,
              textAlign: TextAlign.center,
              style: !isTablet ? style.title : style.titleTablet,
            ),
            const SizedBox(height: 8.0),
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
                    imageUrl: article.image_url!,
                    placeholder: (context, url) => Container(
                      height: isTablet ? 360 : 180,
                      width: MediaQuery.of(context).size.width,
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
            const SizedBox(height: 8.0),
            Text(article.text!,
                textAlign: TextAlign.center,
                style: !isTablet ? style.subtTitle : style.subtTitleTablet),
            ShareButton(),
            Divider(
              color: style.dividerColor,
              thickness: 0.2,
            ),
          ],
        ),
      );
    });
  }
}
