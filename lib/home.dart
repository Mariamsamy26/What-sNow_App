import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/layout/favoritesTap.dart';
import 'package:newsapp/layout/historyTap.dart';
import 'package:newsapp/layout/settingTap/settingScreen.dart';

import 'color_manager.dart';
import 'layout/HomeTab/homeScreen.dart';

class home extends StatefulWidget {
  static const String rountName = 'home';

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: ColorManager.primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: currentIndex,
          selectedItemColor: ColorManager.colorOffwhite,
          unselectedItemColor: ColorManager.colorblueblack,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 22,
                ),
                label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 22),
                label: "favorite"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  size: 22,
                ),
                label: "history"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 22),
                label: "settings"),
          ],
        ),
      ),

    );
  }
}

List<Widget> tabs = [
  HomeScreen(),FavororitesTab(),HistoryTab(),SettingScreen()
];
