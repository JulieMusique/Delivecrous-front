import 'package:deliveryapp/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    required String hintText,
    EdgeInsets padding = const EdgeInsets.only(left: 40),
    Key? key,
  })  : _hintText = hintText,
        _padding = padding,
        super(key: key);

  final String _hintText;
  final EdgeInsets _padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
        color: AppColor.placeholderBg,
        shape: StadiumBorder(),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(  Icons.email,)
                    ),
          hintText: _hintText,
         
          contentPadding: _padding,
        ),
      ),
    );
  }
}
