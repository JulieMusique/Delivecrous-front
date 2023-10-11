import 'package:flutter/material.dart';
import 'package:flutter_ui_food_delivery_app/utils/colors.dart';

class AppInputText extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
final TextInputType? keyboardType; // Ajoutez le paramètre keyboardType
  final String? labelText; // Ajoutez le paramètre labelText
final bool obscureText;
  const AppInputText({required this.controller, required this.hint, this.keyboardType, // Mettez à jour le constructeur
    this.labelText,this.obscureText = false});

  @override
  _AppInputTextState createState() => _AppInputTextState();
}

class _AppInputTextState extends State<AppInputText> {
  EdgeInsets padding = const EdgeInsets.only(left: 40);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
        color: AppColor.placeholderBg,
        shape: StadiumBorder(),
      ),
      child: Stack(
        children: [
          TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
                  labelText: widget.labelText, // Utilisez labelText

              hintStyle: TextStyle(
                color: AppColor.placeholder,
              ),
              contentPadding: padding,
            ),
             keyboardType: widget.keyboardType, // Utilisez keyboardType
  obscureText: widget.obscureText ?? false,
          ),
          
        ],
      ),
    );
  }
}