import 'package:flutter/material.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/strings_manager.dart';
import 'package:movies_app/presentation/screens/home/tabs/browse/view/browse_tab_view.dart';
import 'package:movies_app/presentation/screens/home/tabs/home/home_tab.dart';
import 'package:movies_app/presentation/screens/home/tabs/search/search_tab.dart';
import 'package:movies_app/presentation/screens/home/tabs/watch_list/watch_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTabView(),
    // BrowseTab(),
    WatchTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsManager.bottomBar,
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        selectedItemColor: ColorsManager.selectedIcon,
        unselectedItemColor: ColorsManager.unselectedIcon,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AssetsManager.iconHome)),
              label: StringsManager.homeLabel),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: StringsManager.searchLabel),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AssetsManager.iconBrowse)),
              label: StringsManager.browseLabel),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AssetsManager.iconWatch)),
            label: StringsManager.watchLabel,
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}
