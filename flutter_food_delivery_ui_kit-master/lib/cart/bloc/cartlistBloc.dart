import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_ui_food_delivery_app/cart/bloc/provider.dart';
import 'package:flutter_ui_food_delivery_app/model/list_food.dart';
import 'package:rxdart/rxdart.dart';

class CartListBloc extends BlocBase {
  CartListBloc();

  var _listController = BehaviorSubject<List<Food>>.seeded([]);

//provider class
  CartProvider provider = CartProvider();

//output
  Stream<List<Food>> get listStream => _listController.stream;

//input
  Sink<List<Food>> get listSink => _listController.sink;

  addToList(Food Food) {
    listSink.add(provider.addToList(Food));
  }

  removeFromList(Food Food) {
    listSink.add(provider.removeFromList(Food));
    
  }

//dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _listController.close();
    super.dispose();
  }
}
