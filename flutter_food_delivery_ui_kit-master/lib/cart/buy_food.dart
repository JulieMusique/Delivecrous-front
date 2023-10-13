import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyFood extends StatefulWidget {
  const BuyFood({Key? key}) : super(key: key);

  @override
  State<BuyFood> createState() => _BuyFoodState();
}

class _BuyFoodState extends State<BuyFood> {
  var buyFood = 1;

  void _incFood() {
    setState(() {
      buyFood++; // Incrémente la quantité d'aliments sélectionnés lors de l'appui sur le bouton d'ajout
    });
  }

  void _decFood() {
    setState(() {
      if (buyFood > 1) {
        // Vérifie que la quantité d'aliments sélectionnés est supérieure à 1 avant de décrémenter
        buyFood--; // Décrémente la quantité d'aliments sélectionnés lors de l'appui sur le bouton de réduction
      } else {
        // Si la quantité est déjà à 1, reste à 1 pour éviter des valeurs négatives
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
            Icons.remove, // Icône de réduction
            color: Colors.white, // Couleur de l'icône
          ),
        ),
        Text(
          "$buyFood", // Nombre d'aliments sélectionnés
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
