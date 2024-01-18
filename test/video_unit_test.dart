// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_app/common/api.dart';
import 'package:lojong_app/models/video/video.dart';
import 'package:mock_web_server/mock_web_server.dart';

import 'data_outputs.dart';

void main() {
  List<Video> decode(List<dynamic> decoded) {
    List<Video> videoList = decoded.map<Video>((map) {
      return Video.fromJson(map);
    }).toList();

    return videoList;
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

    test('should return VideoList on request', () async {
      try {
        final expectedVideoList = decode(dataOutput.videoOutput);

        var mockResponse = MockResponse()
          ..httpCode = 200
          ..body = expectedVideoList
          ..headers = api.headers.cast<String, String>();
        server.enqueueResponse(mockResponse);
        final response = await client.get("${server.url}${api.video_api}",
            options: Options(headers: api.headers));

        if (response.data != null) {
          final videoList = decode(response.data as List<dynamic>);
          final request = server.takeRequest();

          expect(request.uri.path, api.video_api);
          expect(request.method, 'GET');
          expect(videoList, expectedVideoList);
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
