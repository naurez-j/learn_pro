import 'package:flutter/material.dart';
import 'package:learn_pro/utils/app_styles.dart';

class CustomButton extends StatefulWidget {
  final String title;
  IconData? prefixIcon;
  final VoidCallback onTap;

  CustomButton({super.key, required this.title, this.prefixIcon,required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          widget.onTap();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: Colors.black,
                  )
                : Container(),
            SizedBox(width: 10,),
            Text(
              widget.title,
              style: AppStyles.blackBold14,
            ),
          ],
        ));
  }
}
