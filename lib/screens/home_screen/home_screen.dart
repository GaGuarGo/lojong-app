import 'package:flutter/material.dart';
import 'package:lojong_app/screens/data_screen/data_screen.dart';
import 'package:lojong_app/screens/home_screen/components/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorDark),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: const Text(
          "INSPIRAÇÕES",
          style:
              TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Asap"),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Stack(children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeNavigationBar(),
            ],
          ),
          LayoutBuilder(builder: (context, constraints) {
            double tabletWidth = 736.0;
            bool isTablet = constraints.maxWidth >= tabletWidth;
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: isTablet
                      ? MediaQuery.of(context).size.height * 0.85
                      : constraints.maxWidth > 500
                          ? MediaQuery.of(context).size.height * 0.80
                          : MediaQuery.of(context).size.height * 0.78,
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          //TELAS
                          DataScreen(option: "Videos"),
                          DataScreen(option: "Articles"),
                          DataScreen(option: "Quotes"),
                        ]),
                  ),
                ),
              ],
            );
          }),
        ]),
      ),
    );
  }
}
