import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  TextEditingController? controller;
  Function()? onTap;
  IconData? icon;
  String?hintText;
  TextInputType? type;
  TextWidget({
    super.key,
    required this.style,
    this.controller,
    this.onTap,
    this.icon,
    this.hintText,
    this.type,
  });

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: style,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        suffixIcon: InkWell(onTap: onTap, child: Icon(icon)),
      ),
    );
  }
}
