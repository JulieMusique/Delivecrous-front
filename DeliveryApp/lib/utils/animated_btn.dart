import 'package:deliveryapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    Key? key,
    required RiveAnimationController btnAnimationController,
    required String choix,
    required this.press,
  })  : _btnAnimationController = btnAnimationController,
        _choix = choix,
        super(key: key);

  final RiveAnimationController _btnAnimationController;
  final VoidCallback press;
  final String _choix;

  @override
  Widget build(BuildContext context) {
    final isLogin = _choix == "Newuser";

    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 64,
        width: 236,
        child: Stack(
          children: [
            
            
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: press,
                  borderRadius: BorderRadius.circular(32),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: isLogin ? AppColor.orange : Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: isLogin ?Colors.white: AppColor.orange  ,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        isLogin ? "Create an Account" : "Login",
                        style: TextStyle(
                          color: isLogin ? Colors.white: AppColor.orange ,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
