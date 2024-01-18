import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: SegmentedTabControl(
        radius: const Radius.circular(24),
        indicatorPadding: const EdgeInsets.all(4),
        backgroundColor: Theme.of(context).primaryColorDark,
        tabTextColor: Colors.white,
        selectedTabTextColor: Theme.of(context).primaryColor,
        squeezeIntensity: 5,
        height: 45,
        tabPadding: const EdgeInsets.symmetric(horizontal: 8),
        tabs: const [
          SegmentTab(
            label: 'VÍDEOS',
            color: Colors.white,
          ),
          SegmentTab(
            label: 'ARTIGOS',
            color: Colors.white,
          ),
          SegmentTab(
            label: 'CITAÇÕES',
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
