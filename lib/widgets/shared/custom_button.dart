import 'package:flutter/material.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';

class CustomButton extends ElevatedButton {
  CustomButton({
    super.key,
    super.onPressed,
    required BuildContext context,
    Widget? child,
    String? label,
    Color? color,
    Color? colorText,
    bool outlined = false,
  }) : super(
    style: ElevatedButton.styleFrom(
      backgroundColor: color ?? (outlined ? Colors.transparent : context.colors.primary),
      foregroundColor: colorText ?? (outlined ? context.colors.primary : context.colors.onPrimary),
      side: outlined ? BorderSide(color: context.colors.primary) : BorderSide.none,
      elevation: 0,
    ),
    child: Center(child: child ?? Text(label ?? '', textAlign: TextAlign.center)),
  );
}
