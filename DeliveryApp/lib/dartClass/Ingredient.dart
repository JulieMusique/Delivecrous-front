class Ingredient {
  late int idIngredient;
  late String name;
  late int calorie;
  late List allergenList;

  Ingredient({required idIngredient,
    required name,
    required calorie,
    required price,
    required allergenList});

  factory Ingredient.fromJson(Map<String, dynamic> json){
    return Ingredient(
        idIngredient: json['idIngredient'],
        name: json['name'],
        calorie: json['calorie'],
        price: json['price'],
        allergenList: json['allergenList']
    );
  }

  @override
  String toString(){
    return "Plat : $idIngredient\n$name\n$calorie\n$allergenList\n";

  }
}