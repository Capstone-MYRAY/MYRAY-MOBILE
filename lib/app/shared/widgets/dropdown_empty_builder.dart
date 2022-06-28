import 'package:flutter/material.dart';

class DropdownEmptyBuilder extends StatelessWidget {
  final String msg;
  const DropdownEmptyBuilder({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          msg,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
