import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/Favorite/bloc/FavoriteslistBloc.dart';
import 'package:flutter_ui_food_delivery_app/http/HttpServiceFav.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/utils/style.dart';
import '../model/User.dart';
import 'bloc/listTileColorBloc.dart';

class FavoriteScreen extends StatefulWidget {
  final User user;
  FavoriteScreen({required this.user});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteListBloc bloc;
  late Future<List<Food>> foodItems;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.getBloc<FavoriteListBloc>();
    fetchFavoriteDishes(widget.user.id ?? 0).then((list) {
      if (list.isNotEmpty) {
        setState(() {
          print(list);
          foodItems = Future.value(list);
        });
      } else {
        setState(() {
          foodItems = Future.error(
              "No data found"); // Mettez un message d'erreur approprié
        });
      }
    }).catchError((error) {
      setState(() {
        foodItems = Future.error(error);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Food>>(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: SafeArea(
              child: FavBody(foodItems), // Utilisez snapshot.data au lieu de foodItems
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Text("An error occurred: ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: CircularProgressIndicator(),
          );
        } else {
          // Si aucune des conditions ci-dessus n'est remplie, vous pouvez renvoyer un widget par défaut.
          return Container(
            child: Text("Waiting for data..."),
          );
        }
      },
    );
  }
}
class FavBody extends StatelessWidget {
  final Future<List<Food>> foodItems;

  FavBody(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food>>(
      future: foodItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Si le Future est en cours d'exécution, affichez un indicateur de chargement.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // En cas d'erreur, affichez un message d'erreur.
          return Text("An error occurred: ${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Si des données sont disponibles et non vides, affichez la liste d'articles.
          return Container(
            padding: EdgeInsets.fromLTRB(20, 30, 15, 0),
            child: Column(
              children: <Widget>[
                CustomAppBar(),
                Expanded(
                  flex: 1,
                  child: foodItemList(snapshot.data!), // Utilisez snapshot.data au lieu de foodItems
                )
              ],
            ),
          );
        } else {
          // Si aucune des conditions ci-dessus n'est remplie, affichez un message approprié.
          return noItemContainer();
        }
      },
    );
  }
/*
class FavBody extends StatelessWidget {
  final Future<List<Food>> foodItems;

  FavBody(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 15, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemList() : noItemContainer(),
          )
        ],
      ),
    );
  }
*/
  Container noItemContainer() {
    return Container(
      child: Center(
        child: Text(
          "No More Items Left In Favoris",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              fontSize: 20),
        ),
      ),
    );
  }
ListView foodItemList(List<Food> foodItems) {
  return ListView.builder(
    itemCount: foodItems.length,
    itemBuilder: (context, index) {
      return FavoriteListItem(foodItem: foodItems[index]);
    },
  );
}
 /* ListView foodItemList() {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return FavoriteListItem(foodItem: foodItems[index]);
      },
    );
  }*/
}

class FavoriteListItem extends StatelessWidget {
  final Food foodItem;

  FavoriteListItem({required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(foodItem.id.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          color:
              vermilion, // Couleur d'arrière-plan lorsque vous faites glisser l'élément
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
        ),
        onDismissed: (direction) {
          final FavoriteListBloc bloc =
              BlocProvider.getBloc<FavoriteListBloc>();

          // Supprimez l'élément de la liste des favoris en utilisant le bloc
          // Fonction pour supprimer un aliment du panier
          bloc.removeFromList(foodItem);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${foodItem.title} retiré des favoris'),
              duration: Duration(seconds: 1),
            ),
          );
          // Vous devrez également mettre à jour l'interface utilisateur ici

          // Affiche un message en bas de l'écran
          // pour refléter les changements dans la liste des favoris
        },
        child: LongPressDraggable(
          hapticFeedbackOnStart: false,
          maxSimultaneousDrags: 1,
          data: foodItem,
          feedback: DraggableChildFeedback(foodItem: foodItem),
          child: DraggableChild(foodItem: foodItem),
          childWhenDragging: foodItem.quantity > 1
              ? DraggableChild(foodItem: foodItem)
              : Container(),
        ));
  }
}

class DraggableChild extends StatelessWidget {
  const DraggableChild({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  final Food foodItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(
        foodItem: foodItem,
      ),
    );
  }
}

class DraggableChildFeedback extends StatelessWidget {
  const DraggableChildFeedback({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  final Food foodItem;

  @override
  Widget build(BuildContext context) {
    final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

    return Opacity(
      opacity: 0.7,
      child: Material(
        child: StreamBuilder(
          stream: colorBloc.colorStream,
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: snapshot.data != null ? snapshot.data : Colors.white,
              ),
              child: ItemContent(foodItem: foodItem),
            );
          },
        ),
      ),
    );
  }
}

class ItemContent extends StatelessWidget {
  const ItemContent({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  final Food foodItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(blurRadius: 10, color: AppColor.lighterGray)],
        color: AppColor.white,
      ),
      child: Row(
        children: [
          Row(
            children: [
              Hero(
                tag: foodItem.imagePath,
                child: Image.asset(
                  foodItem.imagePath,
                  width: MediaQuery.of(context).size.width / 6,
                ),
              ),
              SizedBox(width: 16), // Espace entre l'image et le nom/prix
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    text: foodItem.title,
                    size: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  PrimaryText(
                    text: '\$${foodItem.price}',
                    size: 16,
                    color: AppColor.lightGray,
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        child: Icon(
          CupertinoIcons.back,
          size: 20,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "My Favorite Dishes",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    );
  }
}
/*
class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavoriteListBloc bloc = BlocProvider.getBloc<FavoriteListBloc>();
    List<Food> foodItems;
    return StreamBuilder(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data!;
          return Scaffold(
            body: SafeArea(
              child: FavBody(foodItems),
            ),
          );
        } else {
          return Container(
            child: Text("Something returned null"),
          );
        }
      },
    );
  }
}*/