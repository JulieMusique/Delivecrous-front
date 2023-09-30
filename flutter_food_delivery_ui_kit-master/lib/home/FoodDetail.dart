import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/home/home_screen.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';

class DetailFood extends StatelessWidget {
  final Food food;
  const DetailFood({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                color: Color(0xFFD2F5AF),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            CupertinoIcons.chevron_left_square_fill,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        FavB(food: food,),
                      ],
                    ),
                    Image.asset(
                      food.imagePath,
                      width: 250,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      food.category,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$" + food.price.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: vermilion,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: BuyFood(),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      food.description,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Allergene : ",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                      ),
                    ),
                     Text(
                      food.allergene,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {},
          child: Text("Buy Now" ,style: TextStyle(
    color: vermilion,
  ),),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(251, 255, 255, 255),
            padding: EdgeInsets.all(25),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            textStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}

class BuyFood extends StatefulWidget {
  const BuyFood({Key? key}) : super(key: key);

  @override
  State<BuyFood> createState() => _BuyFoodState();
}

class _BuyFoodState extends State<BuyFood> {
  var buyFood = 1;

  void _incFood() {
    setState(() {
      buyFood++;
    });
  }

  void _decFood() {
    setState(() {
      if (buyFood > 1) {
        buyFood--;
      } else {
        buyFood = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _decFood,
          icon: Icon(
            Icons.remove,
            color: Colors.white,
          ),
        ),
        Text(
          "$buyFood",
          style: TextStyle(color: Colors.white),
        ),
        IconButton(
          onPressed: _incFood,
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}