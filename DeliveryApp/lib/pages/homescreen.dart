import 'package:deliveryapp/pages/animated_btn.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'sign_in_dialog.dart';
import '../constants/colors.dart';
import '../utils/helper.dart';

class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({super.key});

  @override
  State<OnbodingScreen> createState() => LandingScreen();
}

class LandingScreen extends State<OnbodingScreen> {
  late RiveAnimationController _btnAnimationController;
  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Helper.getScreenWidth(context),
      height: Helper.getScreenHeight(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child : ClipPath(
              clipper : CustomClipperAppBar(),
            child: Container(
              width: double.infinity,
              height: Helper.getScreenHeight(context) * 0.5,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.placeholder,
                    offset: Offset(0, 15),
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: AppColor.orange,
              ),
              alignment:  Alignment.center,
                child: Image.asset(
                  Helper.getAssetName("login_bg.png", "virtual"),
                   width: double.infinity, // Ajustez la largeur de l'image
            height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),),
            ),
          
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              Helper.getAssetName("logo.png", "virtual"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: Helper.getScreenHeight(context) * 0.3,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  
                    Text(
                      "Discover the best foods from us\nand fast delivery to your doorstep",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18, // Ajustez la taille de police
                        fontFamily: "VotrePolice", // Ajustez la police
                        fontWeight: FontWeight.bold, // Ajustez le poids de la police
                        color: Color(0xFF4c2610),
                      ),),
                  
                  const Spacer(
                    flex: 2,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      choix: "Alreadyuser",
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            showCustomDialog(
                              context,
                              onValue: (_) {
                                setState(() {
                                  isShowSignInDialog = false;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      choix: "Newuser",
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            showCustomDialog(
                              context,
                              onValue: (_) {
                                setState(() {
                                  isShowSignInDialog = false;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
class CustomClipperAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
     Offset controlPoint = Offset(size.width * 0.23, size.height);
     Offset endPoint = Offset(size.width * 0.25, size.height * 0.98);
     Offset controlPoint2 = Offset(size.width * 0.35, size.height * 0.75);
     Offset endPoint2 = Offset(size.width * 0.5, size.height * 0.75);
     Offset controlPoint3 = Offset(size.width * 0.65, size.height * 0.75);
     Offset endPoint3 = Offset(size.width * 0.77, size.height * 0.98);
     Offset controlPoint4 = Offset(size.width * 0.78, size.height);
    Offset  endPoint4 = Offset(size.width * 0.82, size.height);

    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.21, size.height)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint2.dx,
        endPoint2.dy,
      )
      ..quadraticBezierTo(
        controlPoint3.dx,
        controlPoint3.dy,
        endPoint3.dx,
        endPoint3.dy,
      )
      ..quadraticBezierTo(
        controlPoint4.dx,
        controlPoint4.dy,
        endPoint4.dx,
        endPoint4.dy,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
