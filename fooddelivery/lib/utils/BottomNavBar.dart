import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fooddelivery/Screens/CartScreen.dart';
import 'package:fooddelivery/Screens/FavorisScreen.dart';
import 'package:fooddelivery/Screens/HomeScreen.dart';
import 'package:fooddelivery/Screens/ProfileScreen.dart';

class BottomNavBar extends StatefulWidget {
    const BottomNavBar(
      {Key? key,
      this.home = false,
      this.favoris = false,
      this.profile = false,
      this.panier = false})
      : super(key: key);
       final bool home;
  final bool favoris;
  final bool profile;
  final bool panier;
  @override
  State<BottomNavBar> createState() => _BottomBarState();
}



class _BottomBarState extends State<BottomNavBar> {

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Color.fromARGB(255, 72, 142, 3),
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            print(index);
          },
          items:  [
            GestureDetector(
                    onTap: () {
                      if (!widget.favoris) {
                        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => FavorisScreen()),);
                      }
                    },
                    child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.favorite, size: 25, color: Colors.white),
                Text(
                  'Favoris',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10, 
                  ),
                ),
              ],
            ),),
            GestureDetector(
                    onTap: () {
                      if (!widget.home) {
                        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => HomeScreen()),);
                      }
                    },
                    child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.home,
                  size: 25,
                  color: Colors.white,
                ),
                Text(
                  'Accueil',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),),
           GestureDetector(
                    onTap: () {
                      if (!widget.panier) {
                        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => CartScreen()),);
                      }
                    },
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                  size: 25,
                  color: Colors.white,
                ),
                Text(
                  'Panier',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),),
          GestureDetector(
                    onTap: () {
                      if (!widget.profile) {
                        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => ProfileScreen()),);
                      }
                    },
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 25,
                  color: Colors.white,
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),),
         
          ]),
    );
  }
}