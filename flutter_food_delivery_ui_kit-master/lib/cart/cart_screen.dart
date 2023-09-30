import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/cart/order_confirmed.dart';
import 'package:flutter_ui_food_delivery_app/cart/order_error.dart';
import 'package:flutter_ui_food_delivery_app/home/FoodDetail.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/utils/style.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_button.dart';

import 'bloc/cartlistBloc.dart';
import 'bloc/listTileColorBloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    List<Food> foodItems;
    return StreamBuilder(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data!;
          return Scaffold(
            body: SafeArea(
              child: CartBody(foodItems),
            ),
                        bottomNavigationBar: BottomBar(foodItems),

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
 
  Container totalAmount(List<Food> foodItems) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total:",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          ),
          Text(
            "\$${returnTotalAmount(foodItems)}",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
          ),
        ],
      ),
    );
  }

  String returnTotalAmount(List<Food> foodItems) {
    double totalAmount = 0.0;

    for (int i = 0; i < foodItems.length; i++) {
      totalAmount = totalAmount + foodItems[i].price * foodItems[i].quantity;
    }
    return totalAmount.toStringAsFixed(2);
  }
class BottomBar extends StatefulWidget {
  final List<Food> foodItems;

  BottomBar(this.foodItems);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    updateTotalAmount();
  }

  void updateTotalAmount() {
    double total = 0.0;

    for (int i = 0; i < widget.foodItems.length; i++) {
      total = total + widget.foodItems[i].price * widget.foodItems[i].quantity;
    }

    setState(() {
      totalAmount = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total:",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
                Text(
                  "\$$totalAmount",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                ),
              ],
            ),
          ),
          AppButton(
            bgColor: vermilion,
            borderRadius: 30,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderConfirmed() /*OrderError(),*/
                ),
              );
            },
            text: "Continue",
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}


class CartBody extends StatelessWidget {
  final List<Food> foodItems;

  CartBody(this.foodItems);

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
          "No More Items Left In The Cart",
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
        return CartListItem(foodItem: foodItems[index]);
      },
    );
  }

 
}

class CartListItem extends StatelessWidget {
  final Food foodItem;

  CartListItem({required this.foodItem});

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
                    text: foodItem.name,
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
            child: BuyFood(),
          ),
        ],
      ),
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
          "My Order",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      );
    
  }
}
