// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.onChanged,
    required this.controller,
    this.onFieldSubmitted,
    this.validator,
    this.focusNode,
    this.autofillHints,
    this.readOnly = false,
    this.obscureText = false,
     this.isNumerical = false,
  }) : super(key: key);
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final bool readOnly;
  final bool obscureText;
  final bool isNumerical;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        readOnly: readOnly,
        autofillHints: autofillHints,
        inputFormatters: isNumerical? [FilteringTextInputFormatter.digitsOnly]: null,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        decoration: customInputDecoration(context,
            hintText: hintText,
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon));
  }
}

InputDecoration customInputDecoration(
  BuildContext context, {
  required String? hintText,
  required String? labelText,
  IconData? prefixIcon,
  Widget? suffixIcon,
}) {
  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
  );
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    prefixIcon: prefixIcon != null
        ? Icon(
            prefixIcon,
          )
        : null,
    prefixIconConstraints:
        prefixIcon == null ? BoxConstraints.tight(const Size(8, 0)) : null,
    suffixIcon: suffixIcon,
    border: inputBorder,
    focusedBorder: inputBorder.copyWith(
        borderSide:
            BorderSide(width: 2, color: Theme.of(context).colorScheme.primary)),
    enabledBorder: inputBorder.copyWith(
        borderSide: BorderSide(
            color:
                Theme.of(context).colorScheme.inverseSurface.withOpacity(0.3))),
  );
}
