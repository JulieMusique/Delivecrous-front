import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_food_delivery_app/cart/bloc/cartlistBloc.dart';
import 'package:flutter_ui_food_delivery_app/home/FoodDetail.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/utils/routes.dart';
import 'package:flutter_ui_food_delivery_app/utils/style.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_text.dart';
import 'package:flutter_ui_food_delivery_app/widgets/search_box.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedFoodCard = 0;
  TextEditingController _controller = TextEditingController();
  bool isAscendingOrder = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: AppText(
                text: 'Delicious \n',
                size: 34,
                color: AppColor.black,
                weight: FontWeight.bold,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: AppText(
                text: 'food for you',
                size: 34,
                color: Colors.black,
                weight: FontWeight.bold,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SearchBox(
            enable: false,
            hint: "Search",
            controller: _controller,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.search);
            },
          ),
        ),
        PrimaryText(
          text: 'Categories',
          fontWeight: FontWeight.w700,
          size: 22,
        ),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: foodCategoryList.length,
            itemBuilder: (context, index) => foodCategoryCard(
                foodCategoryList[index].imagePath,
                foodCategoryList[index].name,
                index),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                text: 'Our Delicious dishes',
                fontWeight: FontWeight.w700,
                size: 22,
              ),
              IconButton(
                icon: Icon(
                  Icons.filter_list,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isAscendingOrder = !isAscendingOrder;
                    if (isAscendingOrder) {
                      FoodList.sort((a, b) => a.price.compareTo(b.price));
                    } else {
                      FoodList.sort((a, b) => b.price.compareTo(a.price));
                    }
                  });
                },
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            FoodList.length,
            (index) => FoodCard(
                FoodList[index].imagePath,
                FoodList[index].name,
                FoodList[index].description,
                FoodList[index].price,
                FoodList[index]),
          ),
        ),
      ],
    );
  }

  Widget FoodCard(
      String imagePath, String name, String weight, int price, Food food) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    addToCart(Food foodItem) {
                            bloc.addToList(food);
                          }

                          removeFromList(Food food) {
                            bloc.removeFromList(food);
                          }
    return GestureDetector(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailFood(food: food)))
      },
      child: Container(
        margin: EdgeInsets.only(right: 15, left: 10, top: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(blurRadius: 10, color: AppColor.lighterGray)],
          color: AppColor.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.restaurant,
                            color: Color.fromARGB(255, 89, 154, 23),
                            size: 20,
                          ),
                          Text('$price €')
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: PrimaryText(
                            text: name, size: 22, fontWeight: FontWeight.w700),
                      ),
                      PrimaryText(
                          text: weight, size: 18, color: AppColor.lightGray),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 89, 154, 23),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                      

                          addToCart(food);
                          final snackBar = SnackBar(
                            content: Text('${food.name} added to Cart'),
                            duration: Duration(milliseconds: 550),
                          );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        },
                        child: Icon(Icons.add, size: 20),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      child: Row(
                        children: [
                          FavB(food : food),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              transform: Matrix4.translationValues(30.0, 25.0, 0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 20)]),
              child: Hero(
                tag: imagePath,
                child: Image.asset(imagePath,
                    width: MediaQuery.of(context).size.width / 2.9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget foodCategoryCard(String imagePath, String name, int index) {
    return GestureDetector(
      onTap: () => {
        setState(
          () => {
            print(index),
            selectedFoodCard = index,
          },
        ),
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, top: 10, bottom: 25),
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedFoodCard == index
                ? Color.fromARGB(255, 89, 154, 23)
                : AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.lighterGray,
                blurRadius: 15,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(imagePath, width: 40),
            PrimaryText(text: name, fontWeight: FontWeight.w800, size: 16),
            RawMaterialButton(
                onPressed: null,
                fillColor: selectedFoodCard == index
                    ? AppColor.white
                    : Color.fromARGB(255, 88, 162, 14),
                shape: CircleBorder(),
                child: Icon(Icons.chevron_right_rounded,
                    size: 20,
                    color: selectedFoodCard == index
                        ? AppColor.black
                        : AppColor.white))
          ],
        ),
      ),
    );
  }
}

class FavB extends StatefulWidget {
  final Food food;
      final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  FavB({Key? key, required this.food}) : super(key: key);

  @override
  State<FavB> createState() => _FavBState();
}

class _FavBState extends State<FavB> {
  bool isFav = false;

  // Liste de favoris (utilisée à des fins de démonstration)
  List<Food> favoriteItems = [];
addToFavorite(Food foodItem) {
                            widget.bloc.addToList(foodItem);
                          }

                          removeFromList(Food food) {
                            widget.bloc.removeFromList(food);
                          }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = !isFav;
        });

        // Ajouter ou supprimer l'élément de la liste de favoris ici
        if (isFav) {
          // Ajouter à la liste de favoris
                                    addToFavorite(widget.food);

          favoriteItems.add(widget.food);
          showSnackBar("Ajouté aux favoris");
        } else {
          // Supprimer de la liste de favoris
          favoriteItems.remove(widget.food);
          showSnackBar("Retiré des favoris");
        }
      },
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
        size: 24.0,
      ),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
