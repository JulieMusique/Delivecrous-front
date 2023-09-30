import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ui_food_delivery_app/Favorite/FavoriteOrder.dart';
import 'package:flutter_ui_food_delivery_app/Favorite/bloc/FavoriteslistBloc.dart';
import 'package:flutter_ui_food_delivery_app/cart/bloc/cartlistBloc.dart';
import 'package:flutter_ui_food_delivery_app/cart/bloc/listTileColorBloc.dart';
import 'package:flutter_ui_food_delivery_app/cart/cart_screen.dart';
import 'package:flutter_ui_food_delivery_app/home/home_screen.dart';
import 'package:flutter_ui_food_delivery_app/profile/profile_screen.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';

class MainScreen extends StatefulWidget {
  final VoidCallback onTap;
  final bool collabsed;
  MainScreen({required this.onTap, required this.collabsed});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> widgets = [];

  int _selectedIndex = 0;
  
 void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // Ajoutez ici la logique de navigation
    if (index == 0) {
      // Naviguez vers la première page (par exemple, HomePage)
      Navigator.pop
        (context);
       
    } else if (index == 1) {
      // Naviguez vers la deuxième page (par exemple, FavoritesPage)
  
    
    } else if (index == 2) {
      // Naviguez vers la troisième page (par exemple, HistoryPage)
      
    } else if (index == 3) {
      // Naviguez vers la quatrième page (par exemple, ProfilePage)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }
  @override
  void initState() {
    widgets.add(HomeScreen());
    widgets.add(HomeScreen());
    widgets.add(HomeScreen());
    widgets.add(HomeScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: concrete,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: concrete),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: concrete,
          items: <BottomNavigationBarItem>[
          
            BottomNavigationBarItem(
              label: "Accueil",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Favoris",
              icon: BlocProvider(
                // Ajoutez BlocProvider autour de l'IconButton pour accéder aux BLoCs
                blocs: [
                  // Ajoutez vos BLoCs ici
                  Bloc((i) => FavoriteListBloc()),
                  Bloc((i) => ColorBloc()),
                ],
                dependencies: [],
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoriteScreen()),
                    );
                  },
                  icon: Icon(Icons.favorite_border),
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Historique",
              icon: Icon(Icons.history),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.account_circle),
              
            ),
          ],
          unselectedItemColor: manatee,
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 89, 154, 23) ,
          onTap: _onItemTapped,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.collabsed ? 24 : 0)),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('man.jpeg'),
                      ),
                    ),
                BlocProvider(
      blocs: [
        //add yours BLoCs controlles
        Bloc((i) => CartListBloc()),
        Bloc((i) => ColorBloc()),
      ], dependencies: [],
      child: IconButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartScreen()), 
    );
  },
  icon: SvgPicture.asset(
    "assets/icons/cart.svg",
    width: 24,
    height: 24,
  ),
),),
              
                

                  ],
                ),
                widgets.elementAt(_selectedIndex),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
