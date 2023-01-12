import 'package:flutter/material.dart';
import 'package:tempx_project/utils/konstants.dart';

class DefaultBlueButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget? textOrLoader;
  final String buttonText;
  final double? buttonTextSize;
  final Color? buttonTextColor;
  final Color? buttonColor;
  final void Function() onPress;
  final double? opacity;
  final double? borderRadius;
  final Color? buttonBorderColor;
  const DefaultBlueButton(
      {super.key,
      this.buttonTextColor,
      this.borderRadius,
      this.buttonTextSize,
      this.opacity,
      this.buttonBorderColor,
      this.buttonColor,
      this.textOrLoader,
      required this.buttonText,
      required this.height,
      required this.onPress,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity ?? 1,
      child: Material(
        elevation: 5,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 30),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onTap: onPress,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: buttonColor ?? defaultButtonBlue,
                border: Border.all(color: buttonBorderColor ?? defaultDarkBlue),
                borderRadius: BorderRadius.circular(borderRadius ?? 30)),
            child: Center(
              child: textOrLoader ??
                  Text(
                    buttonText,
                    style: montserrat600.copyWith(
                        fontSize: buttonTextSize ?? 20,
                        color: buttonTextColor ?? defaultLightBlue),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
