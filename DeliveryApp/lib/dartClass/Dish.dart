import 'package:deliveryapp/constants/colors.dart';
import 'package:flutter/material.dart';

import 'Ingredient.dart';

//TODO : Mettre des _
class Dish extends StatelessWidget{ 
  final int id;
  final String title;
  final String description;
  final List categories;
  final int price;
  final String image;
  final List ingredientList;
  final List allergenList;


  const Dish({
    required this.id,
    required this.title,
    required this.description,
    required this.categories,
    required this.price,
    required this.image,
    required this.ingredientList,
    required this.allergenList
  });

  factory Dish.fromJson(Map<String, dynamic> json){
    return Dish(
        id:json['id'],
        title:json['title'],
        description: json['description'],
        categories: json['categories'],
        price: json['price'],
        image: json['image'],
        ingredientList: json['ingredientList'],
        allergenList: json['allergenList'],
    );
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.network(image),
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
                    title,
                                          
                  ),
                  Row(
                    children: [
                      Image.network(image),
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
                        description,
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