import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_food_delivery_app/cart/base.dart';
import 'package:flutter_ui_food_delivery_app/constants/colors.dart';
import 'package:flutter_ui_food_delivery_app/utils/image_path.extension.dart';
import 'package:flutter_ui_food_delivery_app/utils/metrics.dart';
import 'package:flutter_ui_food_delivery_app/utils/navigate.dart';
import 'package:flutter_ui_food_delivery_app/utils/text_theme.dart';
import 'package:flutter_ui_food_delivery_app/widgets/solid_button.dart';
import 'package:lottie/lottie.dart';

class OrderConfirmed extends StatelessWidget {
  const OrderConfirmed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Base(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Container(
          width: w(context),
          height: h(context),
          color: AppColor.orange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ORDER CONFIRMED",
                style: head36(context, AppColor.white),
              ),
              SizedBox(height: hh(context, 50)),
              Container(
                width: ww(context, 157),
                height: ww(context, 157),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, hh(context, 4)),
                      blurRadius: 10,
                    ),
                  ],
                  shape: BoxShape.circle,
                 
                ),
              ),
              Lottie.asset(
                '/anim/confirmed_order.json', // Assurez-vous que le chemin est correct
                fit: BoxFit.contain,
                height: 300,
                width: 300,
              ),
              SizedBox(height: hh(context, 50)),
              horizontalpadding(
                context,
                child: Text(
                  "Hang on Tight! We’ve received your order and we’ll bring it to you ASAP!",
                  textAlign: TextAlign.center,
                  style: body(context, AppColor.white),
                ),
              ),
              SizedBox(height: hh(context, 95)),
              horizontalpadding(
                context,
                child: SolidBorderedButton(
                  onTap: () => popTo(context),
                  text: "TRACK MY ORDER",
                  bgColor: AppColor.white,
                  borderColor: AppColor.white,
                  textColor: AppColor.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}