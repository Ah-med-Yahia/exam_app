import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/assets_managar.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/explore_tab/presentation/views/screens/explore_tab.dart';
import 'package:exam_app/features/home/presentation/views/widgets/nav_bar_icon.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/profile_tab/presentation/profile_tab.dart';
import 'package:exam_app/features/home/presentation/views/screens/tabs/result_tab/presentation/result_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currrentIndex = 0;

  List<Widget> tabs = [
    const ExploreTab(),
    const ResultsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        notchMargin: 2,
        shape: const CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          elevation: 0,
          onTap: (index) {
            if (currrentIndex == index) return;
            currrentIndex = index;
            setState(() {});
          },
          currentIndex: currrentIndex,
          selectedItemColor: ColorManager.blue,
          items: const [
            BottomNavigationBarItem(
              icon: NavBarIcon(image: IconsAssets.exploreIcon, isActive: false),
              activeIcon: NavBarIcon(
                image: IconsAssets.exploreIcon,
                isActive: true,
              ),
              label: UiConstants.explore,
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(image: IconsAssets.resultIcon, isActive: false),
              activeIcon: NavBarIcon(
                image: IconsAssets.resultIcon,
                isActive: true,
              ),
              label: UiConstants.result,
            ),
            BottomNavigationBarItem(
              icon: NavBarIcon(image: IconsAssets.profileIcon, isActive: false),
              activeIcon: NavBarIcon(
                image: IconsAssets.profileIcon,
                isActive: true,
              ),
              label: UiConstants.profile,
            ),
          ],
        ),
      ),
      body: tabs[currrentIndex],
    );
  }
}
