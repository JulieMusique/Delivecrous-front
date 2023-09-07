import 'dart:convert';
import 'dart:io';
import 'package:deliveryapp/dartClass/Dish.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


Future<String> getPublicIpAddress() async {
  try {
    final response = await http.get(Uri.parse('https://api64.ipify.org?format=json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['ip'];
    } else {
      throw Exception('Impossible d\'obtenir l\'adresse IP publique');
    }
  } catch (e) {
    print('Erreur lors de la récupération de l\'adresse IP publique : $e');
    return 'localhost'; // Utilisation de localhost par défaut en cas d'erreur.
  }
}


//GET
Future<List<Dish>> fetchDishes() async {
  String ipAddress = await getPublicIpAddress();
  String url = "http://172.27.216.208:8080/DelivCROUS/dishs";
  if (kDebugMode) {
    print(url);
  }

  http.Response res = await http.get(Uri.parse(url));

  if(res.statusCode == 200){
    List<Dish> dishes = [];
    final List obj = jsonDecode(res.body);
    if (kDebugMode) {
      //print(obj);

    }for(var i=0; i< obj.length; i++){
      dishes.add(Dish(
        id: obj[i]['id'],
        title: obj[i]['title'],
        description: obj[i]['description'],
        categories: obj[i]['categories'],
        price: obj[i]['price'],
        image: obj[i]['image'],
        ingredientList: obj[i]['ingredientList'],
        allergenList: obj[i]['allergenList']
      ));
      if (kDebugMode) {
        print(dishes[i]);
        print("\n");
      }
    }
    return dishes;
  } else {
    return throw Exception('Failed to load dishes');
  }
}


