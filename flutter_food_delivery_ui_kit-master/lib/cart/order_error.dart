


import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/utils/routes.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

class OrderError extends StatelessWidget {
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
              '/anim/error_order.json', // Assurez-vous que le chemin est correct
              fit: BoxFit.contain,
              height: 300,
              width: 300,
            ),
            SizedBox(
                height: 20), // Espacement entre l'animation et le message

            // Message
            Text(
                "SOMETHING WENT WRONG",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
                height: 20), // Espacement entre le message et le bouton

            AppButton(
                bgColor: vermilion,
                borderRadius: 30,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                onTap: () {
                  Navigator.pushNamed(context, Routes.home);
                },
                text:"TRY AGAIN",
                textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
