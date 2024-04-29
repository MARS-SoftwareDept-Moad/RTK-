import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:provider/provider.dart';

import '../../../../shared/state/download_provider.dart';
import '../downloader/downloader.dart';
import '../downloading/downloading.dart';
import '../recovery/recovery.dart';
import '../settingsAndAbout/settings_and_about.dart';
import '../stores/stores.dart';
import '../update/update.dart';
import 'map_view.dart';

class MainMapScreen extends StatefulWidget {
  const MainMapScreen({Key? key}) : super(key: key);

  @override
  State<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> {
  static const Color backgroundColor = Color(0xFFeaf6f5);
  late final PageController _pageController;
  int _currentPageIndex = 0;
  bool extended = false;

  List<NavigationDestination> get _destinations => [
        const NavigationDestination(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        const NavigationDestination(
          icon: Icon(Icons.folder),
          label: 'Stores',
        ),
        const NavigationDestination(
          icon: Icon(Icons.download),
          label: 'Download',
        ),
        const NavigationDestination(
          icon: Icon(Icons.running_with_errors),
          label: 'Recover',
        ),
        const NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        if (Platform.isWindows || Platform.isAndroid)
          const NavigationDestination(
            icon: Icon(Icons.update),
            label: 'Update',
          ),
      ];

  List<Widget> get _pages => [
        const MapPage(), // map View
        const StoresPage(),
        Consumer<DownloadProvider>(
          builder: (context, provider, _) => provider.downloadProgress == null
              ? const DownloaderPage()
              : const DownloadingPage(),
        ),
        RecoveryPage(moveToDownloadPage: () => _onDestinationSelected(2)),
        const SettingsAndAboutPage(),
        if (Platform.isWindows || Platform.isAndroid) const UpdatePage(),
      ];

  void _onDestinationSelected(int index) {
    setState(() => _currentPageIndex = index);
    _pageController.animateToPage(
      _currentPageIndex,
      duration:
          const Duration(milliseconds: 500), // Adjust the duration as needed
      curve: Curves.easeInOut, // Custom animation curve
    );
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPageIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FMTCBackgroundDownload(
        child: Scaffold(
          backgroundColor: backgroundColor,
          bottomNavigationBar: NavigationBar(
            backgroundColor:
                Theme.of(context).navigationBarTheme.backgroundColor,
            onDestinationSelected: _onDestinationSelected,
            selectedIndex: _currentPageIndex,
            destinations: _destinations,
            labelBehavior: MediaQuery.of(context).size.width > 450
                ? null
                : NavigationDestinationLabelBehavior.alwaysHide,
            height: 70,
          ),
          body: Row(
            children: [
              // if (MediaQuery.of(context).size.width > 950)
              //   NavigationRail(
              //     onDestinationSelected: _onDestinationSelected,
              //     selectedIndex: _currentPageIndex,
              //     groupAlignment: 0,
              //     extended: extended,
              //     backgroundColor: backgroundColor,
              //     destinations: _destinations
              //         .map(
              //           (d) => NavigationRailDestination(
              //             icon: d.icon,
              //             label: Text(d.label),
              //             padding: const EdgeInsets.all(10),
              //           ),
              //         )
              //         .toList(),
              //     leading: Row(
              //       children: [
              //         AnimatedContainer(
              //           width: extended ? 205 : 0,
              //           duration: kThemeAnimationDuration,
              //           curve: Curves.easeInOut,
              //         ),
              //         IconButton(
              //           icon: AnimatedSwitcher(
              //             duration: kThemeAnimationDuration,
              //             switchInCurve: Curves.easeInOut,
              //             switchOutCurve: Curves.easeInOut,
              //             child: Icon(
              //               extended ? Icons.menu_open : Icons.menu,
              //               key: UniqueKey(),
              //             ),
              //           ),
              //           onPressed: () => setState(() => extended = !extended),
              //           tooltip: !extended ? 'Extend Menu' : 'Collapse Menu',
              //         ),
              //       ],
              //     ),
              //   ),

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: MediaQuery.of(context).size.width > 950
                        ? const Radius.circular(16)
                        : Radius.zero,
                    bottomLeft: MediaQuery.of(context).size.width > 950
                        ? const Radius.circular(16)
                        : Radius.zero,
                  ),
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _pages,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
