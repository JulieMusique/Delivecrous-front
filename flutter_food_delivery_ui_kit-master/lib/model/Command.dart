import 'package:flutter_ui_food_delivery_app/model/Compose.dart';

class Command {
  int? idCommand;
  int? idUser;
  String? deliveryAdress; // Adresse de livraison
  String orderStatus; // Statut de la commande)
  int totalAmount;
  Compose compose;

  Command({
    this.idCommand,
    required this.idUser,
    required this.deliveryAdress,
    required this.orderStatus,
    required this.totalAmount,
    required this.compose,
  });

  Map<String, dynamic> toJson() {
    return {
      'idCommand': idCommand,
      'idUser': idUser,
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
        deliveryAdress: chaineJson['deliveryAdress'],
        orderStatus: chaineJson['orderStatus'],
        totalAmount: chaineJson['totalAmount'],
        compose: Compose.fromJson(chaineJson['composeItems']));
  }
}
