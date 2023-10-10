import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/Favorite/bloc/FavoriteslistBloc.dart';
import 'package:flutter_ui_food_delivery_app/home/FoodDetail.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/utils/style.dart';
import 'bloc/listTileColorBloc.dart';

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
}

class FavBody extends StatelessWidget {
  final List<Food> foodItems;

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

  ListView foodItemList() {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return FavoriteListItem(foodItem: foodItems[index]);
      },
    );
  }

 
}

class FavoriteListItem extends StatelessWidget {
  final Food foodItem;

  FavoriteListItem({required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      hapticFeedbackOnStart: false,      
      maxSimultaneousDrags: 1,
      data: foodItem,
      feedback: DraggableChildFeedback(foodItem: foodItem),
      child: DraggableChild(foodItem: foodItem),
      childWhenDragging: foodItem.quantity > 1 ? DraggableChild(foodItem: foodItem) : Container(),
      
    );
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
          Container(
            decoration: BoxDecoration(
              color: vermilion,
              borderRadius: BorderRadius.circular(15),
            ),
            child: FavFood(),
          ),
        ],
      ),
    );
  }
}

class FavFood extends StatefulWidget {
  const FavFood({Key? key}) : super(key: key);

  @override
  State<FavFood> createState() => _FavFoodState();
}

class _FavFoodState extends State<FavFood> {
  var FavFood = 1;

  void _incFood() {
    setState(() {
      FavFood++;
    });
  }

  void _decFood() {
    setState(() {
      if (FavFood > 1) {
        FavFood--;
      } else {
        FavFood = 1;
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
            Icons.remove,
            color: Colors.white,
          ),
        ),
        Text(
          "$FavFood",
          style: TextStyle(color: Colors.white),
        ),
        IconButton(
          onPressed: _incFood,
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  AppBar(
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
