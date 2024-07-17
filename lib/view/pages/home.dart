import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies/util/media_query.dart';
import 'package:movies/view/pages/favorite_page.dart';
import 'package:movies/view/pages/home_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Util.getDeviceType(context) == 'phone' ? 8.0 : 30.0,
            horizontal: Util.getDeviceType(context) == 'phone' ? 20.0 : 130.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.shade300,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GNav(
                onTabChange: (value) {
                  setState(() {
                    index = value;
                  });
                },
                color: Colors.black,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                padding: EdgeInsets.all(heightSize / 60),
                backgroundColor: Colors.transparent,
                activeColor: Colors.white,
                gap: Util.getDeviceType(context) == 'phone' ? 8.0 : 20.0,
                tabBackgroundColor: Colors.black,
                tabBorderRadius: 35,
                selectedIndex: index,
                haptic: true,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:
                      Util.getDeviceType(context) == 'phone' ? 15.0 : 25.0,
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
        ),
        body: screen[index],
      ),
    );
  }
}
