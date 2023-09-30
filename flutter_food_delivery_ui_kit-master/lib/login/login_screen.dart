import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/login/login_input_screen.dart';
import 'package:flutter_ui_food_delivery_app/login/sign_up_input_screen.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: TabBarView(
                          children: [LoginInputScreen(), SignUpInputScreen()]),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 4), color: Colors.white)
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                height: MediaQuery.of(context).size.height * 0.4,
                child: Stack(
                  children: [
                    AppBar(
        title: Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
                    Center(
                      child: Lottie.asset(
                '/anim/foodie.json', // Assurez-vous que le chemin est correct
                fit: BoxFit.contain,
                height: 300,
                width: 300,
              ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: TabBar(
                          tabs: [
                            Tab(
                              text: "Login",
                            ),
                            Tab(
                              text: "Sign-Up",
                            )
                          ],
                          labelColor: Colors.black,
                          indicatorColor: vermilion,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
