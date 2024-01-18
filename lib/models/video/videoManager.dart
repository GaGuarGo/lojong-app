// ignore_for_file: file_names
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:lojong_app/common/api.dart';
import 'package:lojong_app/models/network/networkManager.dart';
import 'package:lojong_app/models/video/video.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:path_provider/path_provider.dart';

class VideoManager extends ChangeNotifier {
  NetworkManager? netManager;

  updateConnectivity(NetworkManager networkManager) {
    netManager = networkManager;
    loadAllVideos();
  }

  List<Video> allVideos = [];
  bool isloading = false;
  Dio dio = Dio();

  Api api = Api();

  Future<void> loadAllVideos() async {
    isloading = true;
    notifyListeners();

    var cacheDir = await getTemporaryDirectory();

    var cacheStore = HiveCacheStore(
      cacheDir.path,
      hiveBoxName: api.video_path,
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

    dio.interceptors.add(ChuckerDioInterceptor());
    dio.interceptors.add(DioCacheInterceptor(options: customCacheOptions));

    try {
      // Verificar se há dados em cache antes de fazer a requisição de rede
      var cacheKey =
          customCacheOptions.keyBuilder(RequestOptions(path: api.video_api));
      var cacheData = await customCacheOptions.store?.get(cacheKey);

      if (cacheData != null) {
        // Se existir cache, use os dados em cache
        allVideos =
            decode(cacheData.toResponse(RequestOptions(path: api.video_api)));
        if (kDebugMode) {
          print({
            "message": "Videos Carregados do Cache",
            "data": allVideos,
          });
        }
      } else if (netManager!.isConnected) {
        final response = await dio.get(api.video_api,
            options: Options(headers: api.headers));

        if (response.statusCode == 200) {
          allVideos = decode(response);
          if (kDebugMode) {
            print({
              "message": "Videos Carregados com Sucesso",
              "data": allVideos,
            });
          }
        } else {
          if (kDebugMode) {
            print({
              "message": "Falha ao carregar Vídeos",
              "data": response.data,
            });
          }
        }
      }
      isloading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao carregar Vídeos: ${e.toString()}");
      }
      isloading = false;
      notifyListeners();
    }
  }

  List<Video> decode(Response response) {
    var decoded = response.data as List<dynamic>;

    List<Video> videoList = decoded.map<Video>((map) {
      return Video.fromJson(map);
    }).toList();

    return videoList;
  }
}
