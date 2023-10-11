
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/Favorite/bloc/FavoriteslistBloc.dart';
import 'package:flutter_ui_food_delivery_app/http/HttpServiceFav.dart';
import 'package:flutter_ui_food_delivery_app/model/User.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';

// Widget pour gérer les favoris
class FavB extends StatefulWidget {
  final Food food;
  final User user;
  FavB({Key? key, required this.food, required this.user}) : super(key: key);

  @override
  State<FavB> createState() => _FavBState();
}

class _FavBState extends State<FavB> {
  bool isFav = false; // Indicateur d'état des favoris
  final FavoriteListBloc bloc = BlocProvider.getBloc<FavoriteListBloc>();
  late int userId;

  @override
  void initState() {
    super.initState();

    if (widget.user.id != null) {
      userId = widget.user.id!;
    } else {
      userId = 0;
    }
  }

  // Fonction pour ajouter un aliment au panier
  addToCart(Food food) {
    bloc.addToList(food);
  }

  // Fonction pour supprimer un aliment du panier
  removeFromList(Food food) {
    bloc.removeFromList(food);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = !isFav; // Inversion de l'état des favoris
        });

        // Ajouter ou supprimer l'élément de la liste de favoris ici
        if (isFav) {
          addToCart(widget.food);
          print(widget.food.id);
          addFavoriteDish(userId, widget.food.id);
          // Ajouter à la liste de favoris
          showSnackBar('${widget.food.title} ajouté aux favoris');
        } else {
          removeFromList(widget.food);
          // Supprimer de la liste de favoris
          deleteFavoriteDish(userId, widget.food.id);
          showSnackBar('${widget.food.title} retiré des favoris');
        }
      },
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
        size: 24.0,
      ),
    );
  }

  // Affiche un message en bas de l'écran
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
