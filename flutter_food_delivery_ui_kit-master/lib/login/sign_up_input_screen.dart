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
              AppInputText(
                controller: nameController,
                hint: "FullName",
              ),
              SizedBox(height: 20),
              AppInputText(
                controller: emailController,
                hint: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              AppInputText(
                controller: passwordController,
                hint: "Password",
                obscureText: true,
              ),
              SizedBox(height: 20),
              SizedBox(height: 30),
              AppButton(
                bgColor: vermilion,
                borderRadius: 30,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                onTap: () {
                  // Créez une instance de User avec les données saisies
                  final user =  User(
              firstName: "",
              lastName: "A completer",
              email:"" ,
              address: "A completer",
              phoneNumber: "123-456-7890",
              password: "",
              photoUrl: "",
            );

                  // Passez l'instance de User à ProfileScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(/*user: user*/),
                    ),
                  );
                },
                text: "SignUp",
                textColor: athens_gray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
