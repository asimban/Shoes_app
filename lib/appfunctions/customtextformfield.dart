import 'package:flutter/material.dart';

Widget CustomTextFormField({
  final TextEditingController? controller,
  String? label,
  String? labelStyle,
  bool obscureText = false,
  IconData? prefixIcon,
  String? hintText,
  Widget? suffixIcon,
  String? initialValue,
  int maxLines =1,
  double? width,
  String? Function(String?)? validator,
}) {
  return SizedBox(
    width: width,
    child: TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      initialValue: initialValue,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blueAccent),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon,color: Colors.grey,) : null,
        suffixIcon: suffixIcon,
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff5B9EE1), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(50))
        ),

        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff5B9EE1), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(50))
        ),
        focusedErrorBorder:const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff5B9EE1), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(50))
        ) ,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff5B9EE1) ,width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(50)),

        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20)
      ),

    ),
  );
}



