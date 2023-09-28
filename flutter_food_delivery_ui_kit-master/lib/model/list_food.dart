class FoodCategory {
  String imagePath;
  String name;

  FoodCategory({required this.imagePath, required this.name});
}

class Food {
  String imagePath;
  String name;
  String description;

  Food({required this.imagePath, required this.name, required this.description});
}

 List<FoodCategory> foodCategoryList = [
  FoodCategory(
    imagePath: 'assets/pizza.svg',
    name: 'Pizza',
  ),
  FoodCategory(
    imagePath: 'assets/sea-food.svg',
    name: 'Seafood',
  ),
  FoodCategory(
    imagePath: 'assets/coke.svg',
    name: 'Soft Drinks',
  ),
  FoodCategory(
    imagePath: 'assets/pizza.svg',
    name: 'Healthy',
  ),
  FoodCategory(
    imagePath: 'assets/pizza.svg',
    name: 'Végeterian',
  ),
];

List<Food> FoodList = [
  Food(
    imagePath: 'assets/pizza.png',
    name: 'Primavera Pizza',
    description: 'description 540 gr',
  ),
  Food(
    imagePath: 'assets/pizza-1.png',
    name: 'Cheese Pizza',
    description: 'description 200 gr',
  ),
  Food(
    imagePath: 'assets/salad.png',
    name: 'Healthy Salad',
    description: 'description 200 gr',
  ),
  Food(
    imagePath: 'assets/sandwhich.png',
    name: 'Grilled Sandwhich',
    description: 'description 250 gr',
  ),
  Food(
    imagePath: 'assets/chowmin.png',
    name: 'Cheese Chowmin',
    description: 'description 500 gr',
  ),
];
