import 'package:flutter/material.dart';

class AlignedButton extends StatelessWidget {
  const AlignedButton({Key? key,required this.onPressed, this.icon,required this.btnName}) : super(key: key);
  final String btnName;
  final void Function()? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
        color: Colors.yellow,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0))),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              btnName.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(width: 20.0),
            Icon(
              icon,
              size: 18.0,
            )
          ],
        ),
      ),
    );
  }
}
