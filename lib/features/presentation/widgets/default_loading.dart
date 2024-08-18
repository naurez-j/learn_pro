import 'package:flutter/material.dart';

class DefaultLoading extends StatefulWidget {
  const DefaultLoading({super.key});

  @override
  State<DefaultLoading> createState() => _DefaultLoadingState();
}

class _DefaultLoadingState extends State<DefaultLoading> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Padding(
      padding: EdgeInsets.all(6.0),
      child: CircularProgressIndicator(
        color: Colors.yellow,
        backgroundColor: Colors.black,
      ),
    ),);
  }
}
