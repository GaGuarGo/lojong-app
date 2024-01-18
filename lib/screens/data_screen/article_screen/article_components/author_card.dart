import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lojong_app/common/styles.dart';
import 'package:lojong_app/models/articles/article.dart';

class AuthorCard extends StatelessWidget {
  final Article article;
  AuthorCard({super.key, required this.article});

  final style = Styles();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: style.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: article.author_description == null
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisAlignment:
              article.author_image == null && article.author_description == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
          children: [
            article.author_image != null
                ? ClipOval(
                    child: CachedNetworkImage(
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                      imageUrl: article.author_image!,
                    ),
                  )
                : Container(),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: article.author_description == null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                crossAxisAlignment: article.author_image == null &&
                        article.author_description == null
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    article.author_name!,
                    style: style.title,
                  ),
                  article.author_description != null
                      ? Text(
                          article.author_description!,
                          style: style.subtTitle,
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
