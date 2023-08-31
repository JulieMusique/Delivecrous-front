import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../pages/OnboardingPages/homescreen.dart';
import '../pages/menuScreen.dart';
import '../pages/profileScreen.dart';
import '../pages/favoris.dart';

import '../utils/helper.dart';

class CustomNavBar extends StatelessWidget {
  final bool home;
  final bool menu;
  final bool profile;
  final bool more;

  const CustomNavBar(
      {required Key key,
      this.home = false,
      this.menu = false,
      this.profile = false,
      this.more = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: Helper.getScreenWidth(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              width: Helper.getScreenWidth(context),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColor.placeholder,
                    offset: Offset(0, -5),
                    blurRadius: 10,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!menu) {
                        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => menuScreen()),);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        menu
                            ? Image.asset(
                                Helper.getAssetName(
                                    "more_filled.png", "virtual"),
                              )
                            : Image.asset(
                                Helper.getAssetName("more.png", "virtual"),
                              ),
                        menu
                            ? const Text("Menu",
                                style: TextStyle(color: AppColor.orange))
                            : const Text("Menu"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!profile) {
                       Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ProfileScreen()),);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        profile
                            ? Image.asset(
                                Helper.getAssetName(
                                    "user_filled.png", "virtual"),
                              )
                            : Image.asset(
                                Helper.getAssetName("user.png", "virtual"),
                              ),
                        profile
                            ? const Text("Profile",
                                style: TextStyle(color: AppColor.orange))
                            : const Text("Profile"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!more) {
                        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => menuScreen()),);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        more
                            ? Image.asset(
                                Helper.getAssetName(
                                    "menu_filled.png", "virtual"),
                              )
                            : Image.asset(
                                Helper.getAssetName("menu.png", "virtual"),
                              ),
                        more
                            ? const Text("More",
                                style: TextStyle(color: AppColor.orange))
                            : const Text("More"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: home ? AppColor.orange : AppColor.placeholder,
                onPressed: () {
                  if (!home) {
                    Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => OnbodingScreen()),);
                  }
                },
                child: Image.asset(
                    Helper.getAssetName("home_white.png", "virtual")),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(
      size.width * 0.375,
      0,
      size.width * 0.375,
      size.height * 0.1,
    );
    path.cubicTo(
      size.width * 0.4,
      size.height * 0.9,
      size.width * 0.6,
      size.height * 0.9,
      size.width * 0.625,
      size.height * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.625,
      0,
      size.width * 0.7,
      0.1,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
