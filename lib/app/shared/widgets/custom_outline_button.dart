import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onPressed;
  const CustomOutlineButton({
    Key? key,
    required this.icon,
    required this.text,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: OutlinedButton(
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon),
                const SizedBox(
                  width: 10,
                ),
                Text(text),
              ],
            ),
          )),
    );
    // cons
  }
}
