// ignore_for_file: non_constant_identifier_names

class Api {
  final video_api = "https://applojong.com/api/videos";
  final article_api = "https://applojong.com/api/articles2";
  final article_content_api = "https://applojong.com/api/article-content";
  final quote_api = "https://applojong.com/api/quotes2";

  final video_path = "dio_cache_video";
  final article_path = "dio_cache_article";
  final quote_path = "dio_cache_quote";

  Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer O7Kw5E2embxod5YtL1h1YsGNN7FFN8wIxPYMg6J9zFjE6Th9oDssEsFLVhxf',
    // Adicione outros headers conforme necessário
  };
}
