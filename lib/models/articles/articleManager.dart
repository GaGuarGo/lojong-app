// ignore_for_file: file_names, unnecessary_string_interpolations
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:lojong_app/common/api.dart';
import 'package:lojong_app/models/articles/article.dart';
import 'package:lojong_app/models/network/networkManager.dart';
import 'package:path_provider/path_provider.dart';

class ArticleManager extends ChangeNotifier {
  NetworkManager? netManager;

  updateConnectivity(NetworkManager networkManager) {
    netManager = networkManager;

    _loadAllArticles();
  }

  bool isloading = false;
  bool moreIsLoading = false;
  bool? hasMore;
  int? nextPage;
  int? currentPage;
  bool contentLoading = false;
  Dio dio = Dio();
  Api api = Api();

  List<Article> allArticles = [];
  Article? selectedArtile;

  Future<void> loadArticleContent(int aid) async {
    selectedArtile = Article();
    contentLoading = true;
    notifyListeners();

    try {
      var cacheDir = await getTemporaryDirectory();

      var cacheStore = HiveCacheStore(
        cacheDir.path,
        hiveBoxName: "${api.article_path}",
      );

      var customCacheOptions = CacheOptions(
        store: cacheStore,
        policy: CachePolicy.forceCache,
        priority: CachePriority.high,
        maxStale: const Duration(days: 7),
        hitCacheOnErrorExcept: [401, 404],
        keyBuilder: (request) {
          return request.uri.toString();
        },
        allowPostMethod: false,
      );

      // dio.interceptors.addAll([
      //   ChuckerDioInterceptor(),
      //   DioCacheInterceptor(options: customCacheOptions)
      // ]);
      dio.interceptors.add(DioCacheInterceptor(options: customCacheOptions));

      var cacheKey = customCacheOptions.keyBuilder(RequestOptions(
        path: "${api.article_content_api}?articleid=$aid",
      ));

      var cacheData = await customCacheOptions.store?.get(cacheKey);

      if (cacheData != null) {
        selectedArtile = Article.fromJson(cacheData
            .toResponse(RequestOptions(
                path: "${api.article_content_api}?articleid=$aid"))
            .data);

        if (kDebugMode) {
          print({
            "message": "Artigo Carregado do Cache",
            "data": selectedArtile,
          });
        }
      } else if (netManager!.isConnected) {
        dio.interceptors.add(ChuckerDioInterceptor());

        final response = await dio.get(
          "${api.article_content_api}?articleid=$aid",
          options: Options(headers: api.headers),
        );

        if (response.statusCode == 200 || response.statusCode == 304) {
          selectedArtile = Article.fromJson(response.data);
          if (kDebugMode) {
            print({
              "message": "Artigo Carregado com Sucesso",
              "data": selectedArtile,
            });
          }
        } else {
          if (kDebugMode) {
            print({
              "message": "Falha ao carregar Artigo",
              "data": response.data,
            });
          }
        }
      } else {
        selectedArtile = null;
      }
      contentLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao carregar Artigo: ${e.toString()}");
      }
      contentLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreArticles() async {
    if (await netManager!.canLoadInformation()) {
      try {
        moreIsLoading = true;
        notifyListeners();

        var cacheDir = await getTemporaryDirectory();

        var cacheStore = HiveCacheStore(
          cacheDir.path,
          hiveBoxName: api.article_path,
        );

        var customCacheOptions = CacheOptions(
          store: cacheStore,
          policy: CachePolicy.forceCache,
          priority: CachePriority.high,
          maxStale: const Duration(days: 7),
          hitCacheOnErrorExcept: [401, 404],
          keyBuilder: (request) {
            return request.uri.toString();
          },
          allowPostMethod: false,
        );
        // dio.interceptors.add(ChuckerDioInterceptor());
        dio.interceptors.add(DioCacheInterceptor(options: customCacheOptions));
        if (hasMore == true) {
          final response = await dio.get(
            api.article_api,
            queryParameters: {"page": nextPage},
            options: Options(headers: api.headers),
          );

          if (response.statusCode == 200 || response.statusCode == 304) {
            allArticles.addAll(decode(response));

            if (kDebugMode) {
              print(
                  "Mais Artigos Carregados com Sucesso: ${response.data['list']}");
            }
          } else {
            if (kDebugMode) {
              print("Falha ao carregar mais Artigos: ${response.data}");
            }
          }
        }
        moreIsLoading = false;
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print("Erro ao carregar mais Artigos: $e");
        }
        moreIsLoading = false;
        notifyListeners();
      } finally {
        moreIsLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> _loadAllArticles() async {
    try {
      isloading = true;
      notifyListeners();

      var cacheDir = await getTemporaryDirectory();

      var cacheStore = HiveCacheStore(
        cacheDir.path,
        hiveBoxName: api.article_path,
      );
      var customCacheOptions = CacheOptions(
        store: cacheStore,
        policy: CachePolicy.forceCache,
        priority: CachePriority.high,
        maxStale: const Duration(days: 7),
        hitCacheOnErrorExcept: [401, 404],
        keyBuilder: (request) {
          return request.uri.toString();
        },
        allowPostMethod: false,
      );

      // dio.interceptors.add(ChuckerDioInterceptor());
      dio.interceptors.add(DioCacheInterceptor(options: customCacheOptions));
      var cacheKey = customCacheOptions.keyBuilder(RequestOptions(
        path: api.article_api,
      ));
      var cacheData = await customCacheOptions.store?.get(cacheKey);

      if (cacheData != null) {
        allArticles =
            decode(cacheData.toResponse(RequestOptions(path: api.article_api)));
        if (kDebugMode) {
          print({
            "message": "Artigos Carregados do Cache",
            "data": allArticles,
          });
        }
      } else if (netManager!.isConnected) {
        final response = await dio.get(api.article_api,
            options: Options(headers: api.headers));

        if (response.statusCode == 200) {
          allArticles = decode(response);

          if (kDebugMode) {
            print({
              "message": "Artigos Carregados com Sucesso",
              "data": allArticles,
            });
          }
        } else {
          if (kDebugMode) {
            print({
              "message": "Falha ao carregar Artigos",
              "data": response.data,
            });
          }
        }
      }
      isloading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao carregar Artigos: ${e.toString()}");
      }
      isloading = false;
      notifyListeners();
    }
  }

  List<Article> decode(Response response) {
    var decoded = response.data["list"] as List<dynamic>;
    hasMore = response.data["has_more"];
    nextPage = response.data["next_page"];
    currentPage = response.data["current_page"];

    List<Article> articleList = decoded.map<Article>((map) {
      return Article.fromJson(map);
    }).toList();

    return articleList;
  }
}
