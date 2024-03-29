import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class InputField extends StatelessWidget {
  final Widget icon;
  final String labelText;
  final String placeholder;
  final bool isPassword;
  final bool autoFocus;
  final bool enabled;
  final bool readOnly;
  final int errorMaxLine;
  final int? minLines;
  final int maxLines;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextInputType keyBoardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? inputAction;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;

  const InputField({
    Key? key,
    required this.icon,
    required this.labelText,
    this.controller,
    this.validator,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.placeholder = '',
    this.isPassword = false,
    this.autoFocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.errorMaxLine = 2,
    this.minLines,
    this.maxLines = 1,
    this.suffix,
    this.suffixIcon,
    this.keyBoardType = TextInputType.text,
    this.inputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        labelText: labelText,
        hintText: placeholder,
        errorMaxLines: errorMaxLine,
        suffix: suffix,
        suffixIcon: suffixIcon,
      ),
      minLines: minLines,
      maxLines: maxLines,
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
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
    );
  }
}
