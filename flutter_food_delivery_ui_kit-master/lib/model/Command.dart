import 'package:flutter_ui_food_delivery_app/model/Compose.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';

class Command {
  int? idCommand;
  int? idUser;
  String? orderDate;
  String? deliveryAdress; // Adresse de livraison
  String orderStatus; // Statut de la commande)
  int totalAmount;
  List<Compose> compose;

  Command({
    this.idCommand,
    required this.idUser,
    this.orderDate,
    required this.deliveryAdress,
    required this.orderStatus,
    required this.totalAmount,
    required this.compose,
  });

  List<Food> get foods {
    List<Food> foods = [];
    for (Compose compose in this.compose) {
      foods.add(compose.dish);
    }
    return foods;
  }

  Map<String, dynamic> toJson() {
    return {
      'idCommand': idCommand,
      'idUser': idUser,
      'orderDate': orderDate,
      'deliveryAdress': deliveryAdress,
      'orderStatus': orderStatus,
      'totalAmount': totalAmount,
      'composeItems': compose
    };
  }

  factory Command.fromJson(Map<String, dynamic> chaineJson) {
    return Command(
        idCommand: chaineJson['idCommand']!,
        idUser: chaineJson['idUser'],
        orderDate: chaineJson['orderDate'],
        deliveryAdress: chaineJson['deliveryAdress'],
        orderStatus: chaineJson['orderStatus'],
        totalAmount: chaineJson['totalAmount'],
        compose: chaineJson['composeItems']);
  }
}
