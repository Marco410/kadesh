import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:kadesh/presentation/widgets/app_bar.dart';

import '../screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.background,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const KAppBar(),
      body: _pageSelected(_selectedIndex),
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _selectedIndex,
        margin: const EdgeInsets.only(left: 15, right: 15),
        paddingR: const EdgeInsets.only(bottom: 5, top: 5),
        marginR: const EdgeInsets.only(bottom: 0, top: 0, left: 15, right: 15),
        enableFloatingNavBar: true,
        enablePaddingAnimation: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        dotIndicatorColor: KColors.primaryColor,
        unselectedItemColor: KColors.hintColor,
        selectedItemColor: KColors.primaryColor,
        backgroundColor: KColors.white.withOpacity(0.9),
        curve: Curves.easeInOut,
        borderRadius: 20,
        splashBorderRadius: 30,
        boxShadow: ShadowStyle.containerShadow2,
        items: [
          DotNavigationBarItem(
            icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedHome01,
                color: KColors.dark,
                size: 24),
          ),
          DotNavigationBarItem(
            icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedMapsLocation01,
                color: KColors.dark,
                size: 24),
          ),
          DotNavigationBarItem(
            icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedAddCircle,
                color: KColors.dark,
                size: 24),
          ),
          DotNavigationBarItem(
            icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedStore04,
                color: KColors.dark,
                size: 24),
          ),
          DotNavigationBarItem(
            icon: const HugeIcon(
                icon: HugeIcons.strokeRoundedCash01,
                color: KColors.dark,
                size: 24),
          ),
        ],
      ),
    );
  }

  _pageSelected(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const Home2Screen();
      case 1:
        return const MapScreen();
      case 2:
        return const AddScreen();
      case 3:
        return const DonationScreen();
      case 4:
        return const InfoScreen();
    }
  }
}
