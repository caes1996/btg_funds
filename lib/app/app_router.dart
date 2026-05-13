import 'package:flutter/material.dart';
import 'package:fondo_btg/widgets/layout/container_layout.dart';
import 'package:fondo_btg/features/funds/presentation/pages/funds_page.dart';
import 'package:fondo_btg/features/transactions/presentation/pages/transactions_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String home = '/';
  static const String transactions = '/transactions';

  static String getCurrentRoute(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }
}

final goRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) => ContainerLayout(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const FundsPage(),
        ),
        GoRoute(
          path: AppRoutes.transactions,
          builder: (context, state) => const TransactionsPage(),
        ),
      ],
    ),
  ],
);