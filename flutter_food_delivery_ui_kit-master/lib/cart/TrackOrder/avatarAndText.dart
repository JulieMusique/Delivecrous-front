import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AvatarAndText extends StatefulWidget {
  AvatarAndText({Key? key}) : super(key: key);

  _AvatarAndTextState createState() => _AvatarAndTextState();
}

class _AvatarAndTextState extends State<AvatarAndText>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  final textOne = "Your order is being prepared";

  final imageOne = Lottie.asset(
    '/anim/onTheWay.json', // Assurez-vous que le chemin est correct
    fit: BoxFit.contain,
    height: 350,
    width: 400,
  );
  final textTwo = "Your order is on the Way";
  final imageTwo = Lottie.asset(
    '/anim/Preparing.json', // Assurez-vous que le chemin est correct
    fit: BoxFit.contain,
    height: 300,
    width: 300,
  );
  final imageThree = Lottie.asset(
    '/anim/TimeToPickUporder.json', // Assurez-vous que le chemin est correct
    fit: BoxFit.contain,
    height: 300,
    width: 300,
  );
  final textThree = "Your order is ready to pick up";
  LottieBuilder actualImage = Lottie.asset(
    '/anim/Preparing.json', // Assurez-vous que le chemin est correct
    fit: BoxFit.contain,
    height: 350,
    width: 350,
  );
  var actualText = "";

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 8800),
      vsync: this,
    );
    animationController.forward();
    animationController.addListener(() {
      if (animationController.value < 0.450) {
        setState(() {
          actualImage = imageOne;
          actualText = textOne;
        });
      } else if (animationController.value >= 0.450 &&
          animationController.value < 0.900) {
        setState(() {
          actualImage = imageTwo;
          actualText = textTwo;
        });
      } else if (animationController.value >= 0.900 &&
          animationController.value <= 1.0) {
        setState(() {
          actualImage = imageThree;
          actualText = textThree;
        });
      } else {
        // do nothing
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AvatarAnimation(
        controller: animationController, image: actualImage, text: actualText);
  }
}

class AvatarAnimation extends StatelessWidget {
  AvatarAnimation(
      {Key? key,
      required this.controller,
      required this.image,
      required this.text})
      : super(key: key);

  final AnimationController controller;
  final LottieBuilder image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        image,
        SizedBox(height: 30),
        Text(
          text,
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
