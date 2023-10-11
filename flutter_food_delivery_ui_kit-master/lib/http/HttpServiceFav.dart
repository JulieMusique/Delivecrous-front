import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';
import 'package:http/http.dart' as http;
/*
Future<List<Food>> fetchFavoriteDishes(int userId) async {
  final response = await http
      .get(Uri.parse('http://localhost:8080/DelivCROUS/favoris/$userId'));

  if (response.statusCode == 200) {
    // Si la réponse est OK, parsez la réponse JSON pour obtenir la liste des plats favoris
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => Food.fromJson(json)).toList();
  } else {
    // Gérez les erreurs en fonction du code de statut de la réponse
    throw Exception('Erreur lors de la récupération des plats favoris');
  }
}
*/
Future<List<Food>> fetchFavoriteDishes(int userId) async {
  final response = await http.get(Uri.parse('http://localhost:8080/DelivCROUS/favoris/$userId'));

  if (response.statusCode == 200) {
    List<Food> dishes = [];
    final List obj = jsonDecode(response.body);
    if (kDebugMode) {
      // Affiche les données récupérées
      print(obj);
    }
    for (var i = 0; i < obj.length; i++) {
      List<Ingredient> ingredientList = [];
      for (var ingredientJson in obj[i]['ingredientList']) {
        ingredientList.add(Ingredient.fromJson(ingredientJson));
      }
      dishes.add(Food(
        id: obj[i]['idDish'],
        title: obj[i]['title'],
        description: obj[i]['description'],
        categories: obj[i]['categories'],
        price: obj[i]['price'],
        imagePath: obj[i]['imagePath'],
        ingredients: ingredientList,
        allergens: obj[i]['allergenList']));
    }
    // Affiche les données converties en objets Food
    if (kDebugMode) {
    }
    return dishes;
  } else {
    return throw Exception('Failed to load dishes');
  }
}

      /*
    // Si la réponse est OK, parsez la réponse JSON pour obtenir la liste des plats favoris
    final List<dynamic> jsonList = json.decode(response.body);
    // Vous devez itérer sur la liste JSON et convertir chaque élément en un objet Food
    final List<Food> favoriteDishes = jsonList.map((json) => Food.fromJson(json)).toList();
    return favoriteDishes;
  } else {
    // Gérez les erreurs en fonction du code de statut de la réponse
    throw Exception('Erreur lors de la récupération des plats favoris');
  }
}*/

Future<void> addFavoriteDish(int userId, int dishId) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/DelivCROUS/favoris/$userId/$dishId'),
  );

  if (response.statusCode != 200) {
    // Gérez les erreurs en fonction du code de statut de la réponse
    print("Réponse du serveur : ${response.body}");

    throw Exception('Erreur lors de l\'ajout du plat aux favoris');
  }
}

Future<void> deleteFavoriteDish(int userId, int dishId) async {
  final response = await http.delete(
    Uri.parse('http://localhost:8080/DelivCROUS/favoris/$userId/$dishId'),
  );

  if (response.statusCode == 404) {
    // Gérez les erreurs en fonction du code de statut de la réponse
    print("Réponse du serveur : ${response.body}");

    throw Exception('Erreur lors de l\'ajout du plat aux favoris');
  }
}
