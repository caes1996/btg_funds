import 'package:flutter/material.dart';
import 'package:fondo_btg/app/app_router.dart';
import 'package:fondo_btg/core/constants/app_constants.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/widgets/shared/actions_button_component.dart';
import 'package:go_router/go_router.dart';

class DesktopLayout extends StatelessWidget {
  final Widget child;

  const DesktopLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _TopBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
              child: child
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.dividerColor, width: 1)),
      ),
      child: Row(
        spacing: 16,
        children: [
          Text(AppConstants.appName, style: context.textStyles.displaySmall),
          const Spacer(),
          _NavItem(label: 'Inicio', route: AppRoutes.home, isSelected: _isHome(context)),
          _NavItem(label: 'Historial', route: AppRoutes.transactions, isSelected: !_isHome(context)),
          const SizedBox(width: 24),
          ActionsButtonComponent(),
        ],
      ),
    );
  }

  bool _isHome(BuildContext context) => AppRoutes.getCurrentRoute(context) == AppRoutes.home;
}

class _NavItem extends StatelessWidget {
  final String label;
  final String route;
  final bool isSelected;

  const _NavItem({required this.label, required this.route, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go(route),
      child: Text(
        label, style: context.textStyles.labelLarge?.copyWith(
          color: isSelected ? context.colors.primary : context.colors.onSurfaceVariant
        )
      ),
    );
  }
}
