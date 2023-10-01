import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/model/User.dart';
import 'package:flutter_ui_food_delivery_app/login/profile/profile_screen.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_button.dart';
import 'package:flutter_ui_food_delivery_app/widgets/custom_input.dart';

class SignUpInputScreen extends StatefulWidget {
  SignUpInputScreen();

  @override
  _SignUpInputScreenState createState() => _SignUpInputScreenState();
}

class _SignUpInputScreenState extends State<SignUpInputScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Champ de texte pour le nom complet
              AppInputText(
                controller: nameController,
                hint: "FullName", // Invite de champ pour le nom complet
              ),
              SizedBox(height: 20),
              // Champ de texte pour l'e-mail
              AppInputText(
                controller: emailController,
                hint: "Email", // Invite de champ pour l'e-mail
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              // Champ de texte pour le mot de passe
              AppInputText(
                controller: passwordController,
                hint: "Password", // Invite de champ pour le mot de passe
                obscureText: true, // Le texte est masqué pour les mots de passe
              ),
              SizedBox(height: 20),
              SizedBox(height: 30),
              // Bouton "SignUp" pour s'inscrire
              AppButton(
                bgColor: vermilion,
                borderRadius: 30,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                onTap: () {
                  // Créez une instance de User avec les données saisies
                  final user = User(
                    firstName: "", // À compléter avec le prénom
                    lastName: "À compléter", // À compléter avec le nom de famille
                    email: "", // À compléter avec l'e-mail
                    address: "À compléter", // À compléter avec l'adresse
                    phoneNumber: "123-456-7890", // À compléter avec le numéro de téléphone
                    password: "", // À compléter avec le mot de passe
                    photoUrl: "", // À compléter avec l'URL de la photo
                  );

                  // Passez l'instance de User à ProfileScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(/*user: user*/), // Passez l'utilisateur à l'écran de profil
                    ),
                  );
                },
                text: "SignUp", // Texte du bouton d'inscription
                textColor: athens_gray, // Couleur du texte du bouton
              ),
            ],
          ),
        ),
      ),
    );
  }
}
