import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies/view/util/media_query.dart';
import 'package:movies/view/pages/favorite/favorite_page.dart';
import 'package:movies/view/pages/home/home_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int index = 0;
  final List<Widget> screen = [
    const HomePage(),
    const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final double heightSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              onTabChange: (value) {
                setState(() {
                  index = value;
                });
              },
              color: Colors.white,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              padding: EdgeInsets.all(heightSize / 60),
              backgroundColor: Colors.transparent,
              activeColor: Colors.black,
              gap: Util.getDeviceType(context) == 'phone' ? 8.0 : 20.0,
              tabBackgroundColor: Colors.white,
              tabBorderRadius: 15,
              selectedIndex: index,
              haptic: true,
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Util.getDeviceType(context) == 'phone' ? 15.0 : 25.0,
              ),
              iconSize: Util.getDeviceType(context) == 'phone' ? 20.0 : 35.0,
              tabs: const [
                GButton(
                  icon: Icons.search,
                  text: "Search",
                ),
                GButton(
                  icon: Icons.star,
                  text: "Favorites",
                ),
              ],
            ),
          ),
        ),
        body: screen[index],
      ),
    );
  }
}
