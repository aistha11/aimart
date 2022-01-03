import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.onPressed,
    required this.name,
    required this.color,
    required this.icon,
  }) : super(key: key);
  final void Function()? onPressed;
  final String name;
  final Color color;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: ButtonStyle(
        textStyle:
            MaterialStateProperty.all<TextStyle>(TextStyle(color: color)),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: color),
        )),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0)),
      ),
      icon: Icon(
        icon,
        size: 18.0,
        color: color,
      ),
      label: Text(
        name,
        style: TextStyle(color: color),
      ),
      onPressed: onPressed,
    );
  }
}
