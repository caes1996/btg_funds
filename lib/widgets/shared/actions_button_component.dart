import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fondo_btg/core/constants/app_constants.dart';
import 'package:fondo_btg/core/providers/app_state.dart';
import 'package:fondo_btg/core/providers/theme_provider.dart';
import 'package:fondo_btg/domain/entities/user_balance.dart';
import 'package:hugeicons/hugeicons.dart';

class ActionsButtonComponent extends ConsumerWidget {
  const ActionsButtonComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    return Row(
      spacing: 16,
      children: [
        IconButton(
          onPressed: () => toggleTheme(ref),
          icon: HugeIcon(icon: isDark ? HugeIcons.strokeRoundedSun02 : HugeIcons.strokeRoundedMoon02),
          tooltip: isDark ? 'Modo claro' : 'Modo oscuro',
        ),
        IconButton(
          onPressed: () {
            ref.read(userBalanceProvider.notifier).state =
                UserBalance(availableBalance: AppConstants.initialBalance);
            ref.read(subscriptionsProvider.notifier).state = [];
            ref.read(transactionsProvider.notifier).state = [];
          },
          icon: const HugeIcon(icon: HugeIcons.strokeRoundedReload),
          tooltip: 'Restablecer cuenta',
        ),
      ],
    );
  }
}