import 'package:flutter/material.dart';
import 'package:fondo_btg/app/app_router.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/widgets/shared/actions_button_component.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [ActionsButtonComponent()]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: child
        ),
      ),
      bottomNavigationBar: _BottomBar(),
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(top: BorderSide(color: context.dividerColor, width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.spaceAround,
            children: [
              _BottomNavItem(
                icon: HugeIcons.strokeRoundedHome02,
                label: 'Inicio',
                route: AppRoutes.home,
                isSelected: _isHome(context)
              ),
              _BottomNavItem(
                icon: HugeIcons.strokeRoundedTransactionHistory,
                label: 'Historial',
                route: AppRoutes.transactions,
                isSelected: !_isHome(context)
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isHome(BuildContext context) => AppRoutes.getCurrentRoute(context) == AppRoutes.home;
}

class _BottomNavItem extends StatelessWidget {
  final List<List<dynamic>> icon;
  final String label;
  final String route;
  final bool isSelected;

  const _BottomNavItem({required this.icon, required this.label, required this.route, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? context.colors.primary : context.colors.onSurfaceVariant;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: HugeIcon(icon: icon),
          onPressed: () => context.go(route),
          color: color,
        ),
        Text(label,
          style: context.textStyles.labelSmall?.copyWith(
            color: color,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w400,
            fontSize: isSelected ? 12 : null
          )
        ),
      ],
    );
  }
}
