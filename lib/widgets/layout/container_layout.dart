import 'package:flutter/material.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/widgets/layout/desktop_layout.dart';
import 'package:fondo_btg/widgets/layout/mobile_layout.dart';

class ContainerLayout extends StatelessWidget {
  final Widget child;

  const ContainerLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return MobileLayout(child: child);
    }
    return DesktopLayout(child: child);
  }
}
