import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/http/HttpServiceDish.dart';
import 'package:flutter_ui_food_delivery_app/model/Command.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';

class Compose {
  final QuantityDishKey id;
  final Food dish;
  final Command command;
  final int quantity;

  Compose({
    required this.id,
    required this.dish,
    required this.command,
    required this.quantity,
  });

  factory Compose.fromJson(Map<String, dynamic> json) {
    return Compose(
      id: QuantityDishKey.fromJson(json['id']),
      dish: Food.fromJson(json['dish']),
      command: Command.fromJson(json['command']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      //'dish': dish.toJson(),
      'command': command.toJson(),
      'quantity': quantity,
    };
  }
}

class QuantityDishKey {
  final int idDish;
  final int idCommand;

  QuantityDishKey({
    required this.idDish,
    required this.idCommand,
  });

  factory QuantityDishKey.fromJson(Map<String, dynamic> json) {
    return QuantityDishKey(
      idDish: json['idDish'],
      idCommand: json['idCommand'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idDish': idDish,
      'idCommand': idCommand,
    };
  }
}
