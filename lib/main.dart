import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojong_app/models/articles/articleManager.dart';
import 'package:lojong_app/models/network/networkManager.dart';
import 'package:lojong_app/models/quotes/quoteManager.dart';
import 'package:lojong_app/models/video/videoManager.dart';
import 'package:provider/provider.dart';
import 'package:lojong_app/screens/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ChuckerFlutter.showNotification;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NetworkManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<NetworkManager, VideoManager>(
          create: (_) => VideoManager(),
          lazy: false,
          update: (BuildContext context, networkManager,
                  VideoManager? videoManager) =>
              videoManager!..updateConnectivity(networkManager),
        ),
        ChangeNotifierProxyProvider<NetworkManager, QuoteManager>(
          create: (_) => QuoteManager(),
          lazy: false,
          update: (BuildContext context, networkManager,
                  QuoteManager? quoteManager) =>
              quoteManager!..updateConnectivity(networkManager),
        ),
        ChangeNotifierProxyProvider<NetworkManager, ArticleManager>(
          create: (_) => ArticleManager(),
          lazy: false,
          update: (BuildContext context, networkManager,
                  ArticleManager? articleManager) =>
              articleManager!..updateConnectivity(networkManager),
        ),
      ],
      child: MaterialApp(
        title: 'Lojong App',
        debugShowCheckedModeBanner: false,
        navigatorObservers: [ChuckerFlutter.navigatorObserver],
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFFE09090)),
            primaryColor: const Color(0xFFE09090),
            primaryColorDark: const Color.fromARGB(255, 184, 110, 110),
            fontFamily: 'Asap',
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Asap'),
            useMaterial3: true),
        home: const HomeScreen(),
      ),
    );
  }
}
