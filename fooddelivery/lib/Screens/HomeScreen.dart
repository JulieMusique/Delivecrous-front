import 'package:flutter/material.dart';
import 'package:fooddelivery/utils/BottomNavBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Première Page'),
      ),
      body:BottomNavBar(),
    );
  }
}