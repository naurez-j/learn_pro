import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final IconData prefixIcon;
  CustomTextField({super.key,required this.controller,required this.title,required this.prefixIcon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.title,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        prefixIcon: Icon(
          widget.prefixIcon, // Choose an icon
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(
            color: Colors.white, // White border when not focused
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(
            color: Colors.yellow, // Yellow border when focused
            width: 3,
          ),
        ),
      ),
      cursorColor: Colors.yellow,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
