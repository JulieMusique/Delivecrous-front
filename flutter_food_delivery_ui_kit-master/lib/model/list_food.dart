
class FoodCategory {
  String imagePath;
  String name;

  FoodCategory({required this.imagePath, required this.name});
}

class Food {
    int id;
  String imagePath;
  String name;
  String description;
  int price;
  String category;
  String allergene;
    int quantity;

  Food({required this.id,required this.imagePath, required this.name, required this.description, required this.price,required this.allergene, required this.category,this.quantity=1});
    void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
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
    id:1,
    imagePath: 'assets/pizza.png',
    name: 'Primavera Pizza',
    description: 'description 540 gr',
            category:'pizza',

        price:18,
        allergene: 'vege'

  ),
  Food(
    id:2,
    imagePath: 'assets/pizza-1.png',
    name: 'Cheese Pizza',
    description: 'description 200 gr',
                category:'pizza',

        price:15,
        allergene: 'viande'

  ),
  Food(
    id:3,
    imagePath: 'assets/salad.png',
    name: 'Healthy Salad',
    description: 'description 200 gr',
                category:'salad',

    price:10,        allergene: 'healthy'

  ),
  Food(
    id:4,
    imagePath: 'assets/sandwhich.png',
    name: 'Grilled Sandwhich',
    description: 'description 250 gr',
                category:'sandiwsh',

        price:20,        allergene: 'viande'


  ),
  Food(
    id:5,
    imagePath: 'assets/chowmin.png',
    name: 'Cheese Chowmin',
    description: 'description 500 gr',
                category:'burger',

        price:30,        allergene: 'vege'


  ),
];
