import 'package:deliveryapp/dartClass/Dish.dart';
import 'package:deliveryapp/http/HttpServiceDish.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/helper.dart';
import '../widgets/customNavBar.dart';

class PlatsScreen extends StatefulWidget {
  PlatsScreen({super.key});

  @override
  State<PlatsScreen> createState() => _PlatsScreen();
}

class _PlatsScreen extends State<PlatsScreen> {

  late Future<List<Dish>> listDishes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listDishes = fetchDishes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColor.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Desserts",
                                style: Helper.getTheme(context).headline5,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          Helper.getAssetName("cart.png", "virtual"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                 
                  const SizedBox(
                    height: 15,
                  ),
                  DessertCard(
                    image: Image.asset(
                      Helper.getAssetName("apple_pie.jpg", "real"),
                      fit: BoxFit.cover,
                    ),
                    name: "French Apple Pie",
                    shop: "Minute by tuk tuk",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FutureBuilder<List<Dish>>(
                    future: listDishes,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Load screen
                      } else if (snapshot.hasError) {
                        return Text('Erreur : ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const Text('Aucune donnée disponible.');
                      } else {
                        // Maintenant, vous pouvez accéder aux éléments de la liste listDishes
                        final dishes = snapshot.data;

                        // Utilisez les éléments de la liste comme vous le souhaitez
                        return Dish(
                          id: dishes![0].id,
                          title: dishes[0].title,
                          description: dishes[0].description,
                          categories: dishes[0].categories,
                          price: dishes[0].price,
                          image: dishes[0].image,
                          ingredientList: dishes[0].ingredientList,
                          allergenList: dishes[0].allergenList,
                        );
                        }
                    }

                  ),
              
                  const SizedBox(
                    height: 1000,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomNavBar(
              menu: true,
            ),
          ),
        ],
      ),
    );
  }
}

class DessertCard extends StatelessWidget {
  const DessertCard({
    Key? key,
    required String name,
    required String shop,
    required Image image,
  })  : _name = name,
        _shop = shop,
        _image = image,
        super(key: key);

  final String _name;
  final String _shop;
  final Image _image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: _image,
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.2),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                                          
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Helper.getAssetName("star_filled.png", "virtual"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "3.9",
                        style: TextStyle(color: AppColor.orange),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        _shop,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "_",
                          style: TextStyle(color: AppColor.orange),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Type Plat",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
