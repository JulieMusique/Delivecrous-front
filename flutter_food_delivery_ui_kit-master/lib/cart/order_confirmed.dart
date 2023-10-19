import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/cart/TrackOrder/TrackScreen.dart';
import 'package:flutter_ui_food_delivery_app/model/User.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

class OrderConfirmed extends StatelessWidget {
  final User user;
  OrderConfirmed({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Food Express",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Comic Sans MS, Arial', // Couleur du texte de l'app bar
          ),
        ),
        backgroundColor: Color(0xFFD2F5AF), // Couleur de l'app bar
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lottie Animation
            Lottie.asset(
              '/anim/confirmed_order.json', // Assurez-vous que le chemin est correct
              fit: BoxFit.contain,
              height: 300,
              width: 300,
            ),
            SizedBox(height: 20), // Espacement entre l'animation et le message

            // Message
            Text(
              "ORDER CONFIRMED",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20), // Espacement entre le message et le bouton

            AppButton(
                bgColor: vermilion,
                borderRadius: 30,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TrackingScreen(user: user) /*OrderError(),*/
                        ),
                  );
                },
                text: "TRACK MY ORDER",
                textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
