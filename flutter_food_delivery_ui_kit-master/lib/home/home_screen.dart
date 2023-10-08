import 'package:bloc_pattern/bloc_pattern.dart'; // Importation de BLoC Pattern pour la gestion des BLoCs
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_ui_food_delivery_app/cart/bloc/cartlistBloc.dart'; // Importation du BLoC pour la gestion du panier
import 'package:flutter_ui_food_delivery_app/home/FoodDetail.dart'; // Importation de la page de détail des aliments
import 'package:flutter_ui_food_delivery_app/model/list_food.dart'; // Importation des données sur les aliments
import 'package:flutter_ui_food_delivery_app/utils/colors.dart'; // Importation des couleurs personnalisées
import 'package:flutter_ui_food_delivery_app/utils/routes.dart'; // Importation des itinéraires de navigation
import 'package:flutter_ui_food_delivery_app/utils/style.dart'; // Importation des styles personnalisés
import 'package:flutter_ui_food_delivery_app/widgets/custom_text.dart'; // Importation d'un widget de texte personnalisé
import 'package:flutter_ui_food_delivery_app/widgets/search_box.dart';

import '../http/HttpServiceDish.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedFoodCard =
      -1; // Indice de la catégorie d'aliments sélectionnée. -1 pour dire, qu'au départ, aucune catégorie est selectionnée.
  TextEditingController _controller =
      TextEditingController(); // Contrôleur pour le champ de recherche
  bool isAscendingOrder =
      true; // Indicateur pour l'ordre croissant/décroissant de la liste d'aliments

  late Future<List<Food>> foodList;

  @override
  void initState() {
    super.initState();
    foodList = fetchDishes(urlLocal);
  }

  @override
  void dispose() {
    _controller.dispose(); // Libération des ressources du contrôleur

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      // Réduit la hauteur de la liste pour qu'elle s'adapte au contenu
      children: [
        // En-tête de la page
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20), // Marge à gauche
              child: AppText(
                text: 'Delicious \n',
                // Texte "Delicious" avec un retour à la ligne
                size: 34,
                // Taille du texte
                color: AppColor.black,
                // Couleur du texte
                weight: FontWeight.bold,
                // Poids de la police en gras
                textAlign: TextAlign.start, // Alignement du texte à gauche
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20), // Marge à gauche
              child: AppText(
                text: 'food for you',
                // Texte "food for you"
                size: 30,
                // Taille du texte
                color: Colors.black,
                // Couleur du texte
                weight: FontWeight.bold,
                // Poids de la police en gras
                textAlign: TextAlign.start, // Alignement du texte à gauche
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // Marge verticale
          child: SearchBox(
            enable: false,
            // Désactive la boîte de recherche
            hint: "Search",
            // Texte d'indication dans la boîte de recherche
            controller: _controller,
            // Contrôleur de texte pour la boîte de recherche
            onTap: () {
              Navigator.of(context).pushNamed(
                  Routes.search); // Navigation vers la page de recherche
            },
          ),
        ),
        PrimaryText(
          text: 'Categories', // Texte "Categories"
          fontWeight: FontWeight.w700, // Poids de la police en gras
          size: 22, // Taille du texte
        ),
        SizedBox(
          height: 230, // Hauteur de la liste de catégories alimentaires
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Défilement horizontal
            itemCount: foodCategoryList.length,
            // Nombre d'éléments dans la liste de catégories alimentaires
            itemBuilder: (context, index) => foodCategoryCard(
                foodCategoryList[index].imagePath,
                foodCategoryList[index].name,
                index),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 5),
          // Marge à gauche et en haut
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimaryText(
                text: 'Our Delicious dishes', // Texte "Our Delicious dishes"
                fontWeight: FontWeight.w700, // Poids de la police en gras
                size: 22, // Taille du texte
              ),
              IconButton(
                icon: Icon(
                  Icons.filter_list, // Icône de filtre
                  color: Colors.black, // Couleur de l'icône
                ),
                onPressed: () {
                  setState(() async {
                    List<Food> foods =
                        await Future.wait(foodList as Iterable<Future<Food>>);
                    isAscendingOrder = !isAscendingOrder;
                    if (isAscendingOrder) {
                      foods.sort((a, b) =>
                          a.price.compareTo(b.price)); // Tri en ordre croissant
                    } else {
                      foods.sort((a, b) => b.price
                          .compareTo(a.price)); // Tri en ordre décroissant
                    }
                  });
                },
              ),
            ],
          ),
        ),
        // Liste des aliments générée dynamiquement
        FutureBuilder<List<Food>>(
          future: foodList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Écran de chargement
            } else if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('Aucune donnée disponible.');
            } else {
              final dishes = snapshot.data;

              if (dishes != null) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: dishes.length,
                  itemBuilder: (context, index) {
                    final dish = dishes[index];
                    /* InkWell permet d'afficher une animation d'encre
                              (effet d'onde) lorsque l'utilisateur appuie sur l'objet.
                               Cela montre que l'objet est cliquable
                              */
                    return InkWell(
                        child: FoodCard(dish.imagePath, dish.title,
                            dish.description, dish.price, dish));
                  },
                );
              } else {
                return const Text('Aucun plat trouvé.');
              }
            }
          },
        )
      ],
    );
  }

  // Widget pour afficher une carte d'aliment
  Widget FoodCard(
      String imagePath, String name, String weight, double price, Food food) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

    // Fonction pour ajouter un aliment au panier
    addToCart(Food foodItem) {
      bloc.addToList(food);
    }

    // Fonction pour supprimer un aliment du panier
    removeFromList(Food food) {
      bloc.removeFromList(food);
    }

    return SingleChildScrollView(
        child: GestureDetector(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailFood(food: food)))
      },
      child: Container(
        margin: EdgeInsets.only(right: 15, left: 10, top: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(blurRadius: 10, color: AppColor.lighterGray)],
          color: AppColor.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Alignement du contenu à gauche
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 10),
                  // Ajout de marge supérieure et gauche
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Alignement du contenu à gauche
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.restaurant, // Icône de restaurant
                            color: Color.fromARGB(255, 89, 154, 23),
                            // Couleur de l'icône
                            size: 20, // Taille de l'icône
                          ),
                          Text('$price €')
                          // Affiche le prix en euros à côté de l'icône
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        // Largeur du conteneur de texte en fonction de la largeur de l'écran
                        child: PrimaryText(
                            text: name, // Nom de l'aliment
                            size: 22, // Taille du texte
                            fontWeight:
                                FontWeight.w700), // Poids de la police en gras
                      ),
                      PrimaryText(
                          text: weight, // Poids de l'aliment
                          size: 18, // Taille du texte
                          color: AppColor.lightGray),
                      // Couleur du texte en gris clair
                    ],
                  ),
                ),
                SizedBox(
                  height: 20, // Espace vertical
                ),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                      // Ajout de rembourrage horizontal et vertical au conteneur
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 89, 154, 23),
                        // Couleur de fond du conteneur
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          // Coins inférieurs arrondis à gauche
                          topRight: Radius.circular(
                              20), // Coins supérieurs arrondis à droite
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          addToCart(
                              food); // Appel de la fonction pour ajouter l'aliment au panier
                          final snackBar = SnackBar(
                            content: Text('${food.title} added to Cart'),
                            // Message de la barre d'informations
                            duration: Duration(
                                milliseconds:
                                    550), // Durée d'affichage de la barre d'informations
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              snackBar); // Affichage de la barre d'informations
                        },
                        child: Icon(Icons.add,
                            size: 20), // Icône "Ajouter" dans le conteneur
                      ),
                    ),
                    SizedBox(width: 20), // Espace horizontal
                    SizedBox(
                      child: Row(
                        children: [
                          FavB(food: food), // Widget pour gérer les favoris
                          SizedBox(width: 5), // Espace horizontal
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              // Utilisation de la propriété "transform" pour déplacer l'enfant du Container
              transform: Matrix4.translationValues(30.0, 25.0, 0.0),

              // Configuration de la décoration du Container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // Crée des coins arrondis
                boxShadow: [
                  // Ajoute une ombre au Container
                  BoxShadow(
                    color: Colors.grey, // Couleur de l'ombre
                    blurRadius: 20, // Flou de l'ombre
                  ),
                ],
              ),

              child: Ink.image(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
                child: Image.network(
                  imagePath,
                  width: MediaQuery.of(context).size.width / 5,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  // Widget pour afficher une carte de catégorie d'aliments
  Widget foodCategoryCard(String imagePath, String name, int index) {
    String url;
    return GestureDetector(
      onTap: () => {
        setState(() => {
              // if click again on the same foodCategoryCard, get in foodList all dishs
              if (selectedFoodCard == index)
                {
                  foodList = fetchDishes(urlLocal),
                }
              // Else, get all dishs who contain the selected category
              else
                {
                  selectedFoodCard = index,
                  url = urlLocal + "?selectedCategory=" + name.toUpperCase(),
                  foodList = fetchDishes(url),
                },
            }),
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, top: 10, bottom: 25),
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedFoodCard == index
                ? Color.fromARGB(255, 89, 154, 23)
                : AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.lighterGray,
                blurRadius: 15,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(imagePath, width: 40),
            PrimaryText(text: name, fontWeight: FontWeight.w800, size: 16),
            RawMaterialButton(
                onPressed: () {},
                fillColor: selectedFoodCard == index
                    ? AppColor.white
                    : Color.fromARGB(255, 88, 162, 14),
                shape: CircleBorder(),
                child: Icon(Icons.chevron_right_rounded,
                    size: 20,
                    color: selectedFoodCard == index
                        ? AppColor.black
                        : AppColor.white))
          ],
        ),
      ),
    );
  }
}

// Widget pour gérer les favoris
class FavB extends StatefulWidget {
  final Food food;

  FavB({Key? key, required this.food}) : super(key: key);

  @override
  State<FavB> createState() => _FavBState();
}

class _FavBState extends State<FavB> {
  bool isFav = false; // Indicateur d'état des favoris

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = !isFav; // Inversion de l'état des favoris
        });

        // Ajouter ou supprimer l'élément de la liste de favoris ici
        if (isFav) {
          // Ajouter à la liste de favoris
          showSnackBar("Ajouté aux favoris");
        } else {
          // Supprimer de la liste de favoris
          showSnackBar("Retiré des favoris");
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
