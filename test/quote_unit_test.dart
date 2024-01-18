// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_app/common/api.dart';
import 'package:lojong_app/models/quotes/quote.dart';
import 'package:mock_web_server/mock_web_server.dart';

import 'data_outputs.dart';

void main() {
  List<Quote> decode(List<dynamic> decoded) {
    List<Quote> quoteList = decoded.map<Quote>((map) {
      return Quote.fromJson(map);
    }).toList();

    return quoteList;
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

    test('should return QuoteList on request', () async {
      try {
        final expectedQuoteList = decode(dataOutput.quoteOutput);

        var mockResponse = MockResponse()
          ..httpCode = 200
          ..body = expectedQuoteList
          ..headers = api.headers.cast<String, String>();
        server.enqueueResponse(mockResponse);
        final response = await client.get("${server.url}${api.quote_api}",
            options: Options(headers: api.headers));

        if (response.data != null) {
          final quoteList = decode(response.data["list"] as List<dynamic>);
          final request = server.takeRequest();

          expect(request.uri.path, api.quote_api);
          expect(request.method, 'GET');
          expect(quoteList, expectedQuoteList);
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
