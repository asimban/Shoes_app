import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;



    const CustomButton({super.key,required this.buttonText, required this.onPressed, });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  dynamic size,height,width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SizedBox(
      height: height/15,
      width: width/1,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff5B9EE1), // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Button border radius
          ),
        ),
        child: Text(
          widget.buttonText,
          style: const TextStyle(fontSize: 20), // Text style
        ),
      ),
    );
  }
}

