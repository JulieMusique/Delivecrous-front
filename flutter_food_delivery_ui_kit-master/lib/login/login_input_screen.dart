import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/utils/routes.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_button.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_input.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_text.dart';

class LoginInputScreen extends StatefulWidget {
  LoginInputScreen();

  @override
  _LoginInputScreenState createState() => _LoginInputScreenState();
}

class _LoginInputScreenState extends State<LoginInputScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 24),
        child: Column(
          children: [
            // Champ de texte pour l'e-mail
            Padding(
              padding: EdgeInsets.only(bottom: 42),
              child: AppInputText(
                controller: emailController,
                hint: "Your Email", // Invite de champ pour l'e-mail
              ),
            ),
            // Champ de texte pour le mot de passe
            Padding(
              padding: EdgeInsets.only(bottom: 42),
              child: AppInputText(
                controller: passwordController,
                hint: "Password", // Invite de champ pour le mot de passe
              ),
            ),
            // Texte "Forgot password?" pour réinitialiser le mot de passe
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 42),
                child: AppText(
                  color: vermilion,
                  size: 17,
                  weight: FontWeight.w600,
                  text: "Forgot password?",
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            // Bouton "Login" pour se connecter
            AppButton(
              bgColor: vermilion,
              borderRadius: 30,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              onTap: () {
                Navigator.pushNamed(context, Routes.home); // Naviguer vers la page d'accueil
              },
              text: "Login", // Texte du bouton de connexion
              textColor: athens_gray, // Couleur du texte du bouton
            ),
          ],
        ),
      ),
    );
  }
}
