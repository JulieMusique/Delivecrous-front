import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/http/HttpServiceCart.dart';
import 'package:flutter_ui_food_delivery_app/model/Command.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';

class BuyFood extends StatefulWidget {
  const BuyFood({
    Key? key,
    this.command,
    required this.dish,
  }) : super(key: key);
  final Command? command;
  final Food dish;

  @override
  State<BuyFood> createState() => _BuyFoodState();
}

class _BuyFoodState extends State<BuyFood> {
  var buyFood = 1;
  void _incFood() {
    setState(() {
      if (widget.command == null) {
        final snackBar = SnackBar(
          content: Text('Le plat n a pas pu etre ajoute à la commande'),
          // Message de la barre d'informations
          duration: Duration(
              milliseconds:
                  550), // Durée d'affichage de la barre d'informations
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      addDishToCommand(widget.command!.idCommand, widget.dish.id);
      widget.dish
          .incrementQuantity(); // Incrémente la quantité d'aliments sélectionnés lors de l'appui sur le bouton d'ajout
    });
  }

  void _decFood() {
    setState(() {
      if (widget.command == null) {
        final snackBar = SnackBar(
          content: Text('Le plat n a pas pu etre retire de la commande'),
          // Message de la barre d'informations
          duration: Duration(
              milliseconds:
                  550), // Durée d'affichage de la barre d'informations
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      deleteDishFromCommand(widget.command!.idCommand, widget.dish.id);
      if (widget.dish.quantity > 1) {
        // Vérifie que la quantité d'aliments sélectionnés est supérieure à 1 avant de décrémenter
        widget.dish
            .decrementQuantity(); // Décrémente la quantité d'aliments sélectionnés lors de l'appui sur le bouton de réduction
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
            Icons.remove, // Icône de réduction
            color: Colors.white, // Couleur de l'icône
          ),
        ),
        Text(
          "${widget.dish.quantity}", // Nombre d'aliments sélectionnés
          style: TextStyle(color: Colors.white), // Couleur du texte
        ),
        IconButton(
          onPressed: _incFood,
          icon: Icon(
            Icons.add, // Icône d'ajout
            color: Colors.white, // Couleur de l'icône
          ),
        )
      ],
    );
  }
}
