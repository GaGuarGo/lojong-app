// ignore_for_file: file_names
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:lojong_app/common/api.dart';
import 'package:lojong_app/models/network/networkManager.dart';
import 'package:lojong_app/models/quotes/quote.dart';
import 'package:path_provider/path_provider.dart';

class QuoteManager extends ChangeNotifier {
  NetworkManager? netManager;

  updateConnectivity(NetworkManager networkManager) {
    netManager = networkManager;
    _loadAllQuotes();
  }

  bool isloading = false;
  bool moreIsLoading = false;
  Dio dio = Dio();
  Api api = Api();
  List<Quote> allQuotes = [];
  int? nextPage;
  bool? hasMore;

  Future<void> loadMoreQuotes() async {
    if (await netManager!.canLoadInformation()) {
      try {
        moreIsLoading = true;
        notifyListeners();

        var cacheDir = await getTemporaryDirectory();

        var cacheStore = HiveCacheStore(
          cacheDir.path,
          hiveBoxName: api.quote_path,
        );

        var customCacheOptions = CacheOptions(
          store: cacheStore,
          policy: CachePolicy.forceCache,
          priority: CachePriority.high,
          hitCacheOnErrorExcept: [401, 404],
          keyBuilder: (request) {
            return request.uri.toString();
          },
          allowPostMethod: false,
        );
        if (hasMore == true) {
          dio.interceptors
              .add(DioCacheInterceptor(options: customCacheOptions));

          final response = await dio.get(
            api.quote_api,
            queryParameters: {"page": nextPage},
            options: Options(headers: api.headers),
          );

          if (response.statusCode == 200 || response.statusCode == 304) {
            allQuotes.addAll(decode(response));

            if (kDebugMode) {
              print(
                  "Mais Citações Carregadas com Sucesso: ${response.data['list']}");
            }
          } else {
            if (kDebugMode) {
              print("Falha ao carregar mais Citações: ${response.data}");
            }
          }
        }
        moreIsLoading = false;
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print("Erro ao carregar mais Citações: $e");
        }
        moreIsLoading = false;
        notifyListeners();
      } finally {
        moreIsLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> _loadAllQuotes() async {
    try {
      isloading = true;
      notifyListeners();

      var cacheDir = await getTemporaryDirectory();

      var cacheStore = HiveCacheStore(
        cacheDir.path,
        hiveBoxName: api.quote_path,
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

      dio.interceptors.add(DioCacheInterceptor(options: customCacheOptions));
      var cacheKey = customCacheOptions.keyBuilder(RequestOptions(
        path: api.quote_api,
      ));
      var cacheData = await customCacheOptions.store?.get(cacheKey);

      if (cacheData != null) {
        allQuotes =
            decode(cacheData.toResponse(RequestOptions(path: api.quote_api)));
        if (kDebugMode) {
          print({
            "message": "Citações Carregados do Cache",
            "data": allQuotes,
          });
        }
      } else if (netManager!.isConnected) {
        final response = await dio.get(api.quote_api,
            options: Options(headers: api.headers));

        if (response.statusCode == 200) {
          allQuotes = decode(response);

          if (kDebugMode) {
            print({
              "message": "Citações Carregados com Sucesso",
              "data": allQuotes,
            });
          }
        } else {
          if (kDebugMode) {
            print({
              "message": "Falha ao carregar Citações",
              "data": response.data,
            });
          }
        }
      }
      isloading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao carregar Citações: ${e.toString()}");
      }
      isloading = false;
      notifyListeners();
    }
  }

  // Future<void> _loadAllQuotes2() async {
  //   isloading = true;
  //   notifyListeners();
  //   dio.interceptors.add(ChuckerDioInterceptor());

  //   try {
  //     final response =
  //         await dio.get(api.quote_api, options: Options(headers: api.headers));

  //     if (response.statusCode == 200) {
  //       allQuotes = decode(response);
  //       hasMore = response.data["has_more"];
  //       nextPage = response.data["next_page"];
  //       if (kDebugMode) {
  //         print({
  //           "message": "Citações Carregados com Sucesso",
  //           "data": allQuotes,
  //         });
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print({
  //           "message": "Falha ao carregar Citações",
  //           "data": response.data,
  //         });
  //       }
  //     }
  //     isloading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Erro ao carregar Citações: ${e.toString()}");
  //     }
  //     isloading = false;
  //     notifyListeners();
  //   }
  // }

  List<Quote> decode(Response response) {
    var decoded = response.data["list"] as List<dynamic>;
    hasMore = response.data["has_more"];
    nextPage = response.data["next_page"];

    List<Quote> quoteList = decoded.map<Quote>((map) {
      return Quote.fromJson(map);
    }).toList();
    notifyListeners();

    return quoteList;
  }
}
