import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tempx_project/utils/konstants.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {Key? key,
      this.devHeight,
      this.obscureText,
      required this.hintText,
      required this.onChanged,
      this.hintTextColor,
      this.errorBorder,
      this.focusNode,
      this.controller,
      this.onTap,
      this.maxLength,
      this.readOnly,
      this.keyboardType})
      : super(key: key);

  final bool? errorBorder;
  final double? devHeight;
  final FocusNode? focusNode;
  final int? maxLength;
  final Color? hintTextColor;
  final String hintText;
  final bool? obscureText;
  final TextEditingController? controller;
  final void Function()? onTap;
  final void Function(String) onChanged;
  final bool? readOnly;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      shadowColor: const Color.fromRGBO(54, 67, 115, 0.15),
      borderRadius: BorderRadius.circular(30),
      child: TextField(
        maxLength: maxLength,
        focusNode: focusNode,
        obscuringCharacter: '*',
        obscureText: obscureText ?? false,
        controller: controller,
        onTap: onTap,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 20),
        keyboardType: keyboardType,
        decoration: defaultTextFieldDecoration.copyWith(
            errorBorder: errorBorder == true
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffF0122D)))
                : null,
            contentPadding: const EdgeInsets.all(20),
            counterText: "",
            hintText: hintText,
            filled: true,
            fillColor: textFieldFillColor,
            hintStyle: GoogleFonts.montserrat(
                color: hintTextColor ?? textFieldHintTextLightBlue,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                fontSize: 20)),
      ),
    );
  }
}
