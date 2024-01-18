import 'package:flutter/material.dart';
import 'package:lojong_app/common/styles.dart';
import 'package:lojong_app/models/network/networkManager.dart';
import 'package:provider/provider.dart';

class NoConnectionScreen extends StatelessWidget {
  NoConnectionScreen({super.key});

  final style = Styles();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double tabletWidth = 736.0;
      bool isTablet = constraints.maxWidth >= tabletWidth;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "OPS!",
            textAlign: TextAlign.center,
            style: isTablet ? style.titleTablet : style.title,
          ),
          const SizedBox(height: 8),
          Text(
            "Não foi possivel conectar ao\n servidor, verifique se está\n conectado a internet.",
            style: isTablet ? style.subtTitleTablet : style.subtTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              context.read<NetworkManager>().checkInternetConnection();
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: style.lightGrayColor),
            child: Text(
              "Recarregar",
              textAlign: TextAlign.center,
              style: isTablet ? style.titleTablet : style.title,
            ),
          ),
        ],
      );
    });
  }
}
