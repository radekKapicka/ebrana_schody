import 'package:ebrana_schody/misc/colors.dart';
import 'package:ebrana_schody/pages/navpages/home_page.dart';
import 'package:ebrana_schody/pages/navpages/ladder_page.dart';
import 'package:ebrana_schody/pages/navpages/settings_page.dart';
import 'package:ebrana_schody/pages/navpages/stat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    LadderPage(),
    HomePage(),
    StatPage(),
    SettingsPage(),
  ];
  int currentIndex =0;
  void onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.textColor1,
        selectedItemColor: Colors.white,
        unselectedItemColor: AppColors.whiteGrad,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart),label: "Ladder",),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",),
          BottomNavigationBarItem(icon: Icon(Icons.workspace_premium),label: "Self stats",),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings",),
        ]
      ),
    );
  }
}

