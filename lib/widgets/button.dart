import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? btnText;

  final Color? color;
  final VoidCallback onPressed;

  Button({this.btnText, this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            btnText.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
