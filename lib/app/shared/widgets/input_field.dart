import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Widget icon;
  final String labelText;
  final String placeholder;
  final bool isPassword;
  final bool autoFocus;
  final bool enabled;
  final bool readOnly;
  final int errorMaxLine;
  final TextInputType keyBoardType;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputAction inputAction;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final void Function()? onTap;

  const InputField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.labelText,
    this.validator,
    this.focusNode,
    this.onTap,
    this.placeholder = '',
    this.isPassword = false,
    this.autoFocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.errorMaxLine = 2,
    this.keyBoardType = TextInputType.text,
    this.inputAction = TextInputAction.done,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        labelText: labelText,
        hintText: placeholder,
        errorMaxLines: errorMaxLine,
      ),
      obscureText: isPassword,
      validator: validator,
      autofocus: autoFocus,
      keyboardType: keyBoardType,
      controller: controller,
      textInputAction: inputAction,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      onTap: onTap,
    );
  }
}
