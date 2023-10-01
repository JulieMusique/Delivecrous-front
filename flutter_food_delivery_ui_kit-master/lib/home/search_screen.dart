// Import des packages Flutter nécessaires
import 'package:flutter/material.dart'; // Import du package Material Design
import 'package:flutter_ui_food_delivery_app/utils/colors.dart'; // Import des couleurs personnalisées
import 'package:flutter_ui_food_delivery_app/widgets/custom_text.dart'; // Import du widget de texte personnalisé

// Définition d'une classe SearchScreen qui étend StatefulWidget
class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

// Définition de la classe d'état _SearchScreenState
class _SearchScreenState extends State<SearchScreen> {
  // Contrôleur de texte pour la barre de recherche
  final TextEditingController controller =
      TextEditingController(text: "Search for a dish");

  @override
  void initState() {
    // Logique d'initialisation de l'écran (vide dans cet exemple)
    super.initState();
  }

  @override
  void dispose() {
    // Libération des ressources à la fermeture de l'écran
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Construction de l'interface utilisateur de l'écran de recherche
    return Scaffold(
      body: Stack(
        children: [
          // Conteneur arrière-plan avec une couleur de fond et des éléments d'interface utilisateur
          Container(
            color: gallery, // Couleur d'arrière-plan
            padding: EdgeInsets.all(24), // Marge intérieure
            child: Column(
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height * 0.075, // Espacement
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black, // Couleur de l'icône
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Action de retour
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration.collapsed(
                          hintText: "Search", // Texte de l'indicateur de recherche
                          border: InputBorder.none, // Pas de bordure
                        ),
                        style: TextStyle(color: Colors.black), // Style du texte
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Conteneur avant-plan avec des résultats de recherche
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2), // Marge supérieure
            decoration: BoxDecoration(
                color: alabaster, // Couleur de fond
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))), // Coins arrondis
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: "Found 6  results", // Texte affiché ici  faut mettre une variable n qui indique nb de reusltat trouve exemple 6 
                    size: 28, // Taille de la police
                    color: Colors.black, // Couleur du texte
                    weight: FontWeight.w700, // Poids de la police
                    textAlign: TextAlign.center, // Alignement du texte
                  ),
                ),
                Flexible(
                    child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Nombre de colonnes dans la grille
                      childAspectRatio: 2 / 3, // Ratio largeur/hauteur des éléments
                      crossAxisSpacing: 4.0, // Espacement horizontal entre les éléments
                      mainAxisSpacing: 4.0), // Espacement vertical entre les éléments
                  itemBuilder: (BuildContext context, int index) {
                    // Fonction de construction des éléments de la grille
                    // Vous devez ajouter ici la logique pour afficher les résultats de recherche
                  },
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
