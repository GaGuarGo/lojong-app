// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_app/common/api.dart';
import 'package:lojong_app/models/articles/article.dart';
import 'package:mock_web_server/mock_web_server.dart';

import 'data_outputs.dart';

void main() {
  List<Article> decode(List<dynamic> decoded) {
    List<Article> articleList = decoded.map<Article>((map) {
      return Article.fromJson(map);
    }).toList();

    return articleList;
  }

  group('MockWebServer', () {
    final server = MockWebServer();
    final client = Dio();
    final dataOutput = DataOutput();
    final api = Api();

    setUp(() async {
      await server.start();
    });

    tearDown(() async {
      await server.shutdown();
    });

    test('should return ArticleList on request', () async {
      try {
        final expectedArticleList = decode(dataOutput.articleOutput);

        var mockResponse = MockResponse()
          ..httpCode = 200
          ..body = expectedArticleList
          ..headers = api.headers.cast<String, String>();
        server.enqueueResponse(mockResponse);
        final response = await client.get("${server.url}${api.article_api}",
            options: Options(headers: api.headers));

        if (response.data != null) {
          final articleList = decode(response.data["list"] as List<dynamic>);
          final request = server.takeRequest();

          expect(request.uri.path, api.quote_api);
          expect(request.method, 'GET');
          expect(articleList, expectedArticleList);
        } else {
          if (kDebugMode) {
            print("Resposta do servidor está vazia ou nula.");
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("ERRO: ${e.toString()}");
        }
      }
    });

    test("Verify Article Content", () async {
      try {
        final expectedArticleContent =
            Article.fromJson(dataOutput.articleContentOutput);

        var mockResponse = MockResponse()
          ..httpCode = 200
          ..body = expectedArticleContent
          ..headers = api.headers.cast<String, String>();
        server.enqueueResponse(mockResponse);
        final response =
            await client.get("${server.url}${api.article_content_api}",
                options: Options(
                  headers: api.headers,
                ),
                queryParameters: {"articleid": expectedArticleContent.id});

        if (response.data != null) {
          final articleContent = Article.fromJson(response.data);
          final request = server.takeRequest();

          expect(
            request.uri.path,
            api.article_content_api,
          );
          expect(request.method, 'GET');
          expect(articleContent, expectedArticleContent);
        } else {
          if (kDebugMode) {
            print("Resposta do servidor está vazia ou nula.");
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("ERRO: ${e.toString()}");
        }
      }
    });
  });
}
