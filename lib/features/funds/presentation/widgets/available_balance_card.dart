import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fondo_btg/core/constants/app_constants.dart';
import 'package:fondo_btg/core/providers/app_state.dart';
import 'package:fondo_btg/domain/entities/user_balance.dart';
import 'package:fondo_btg/core/theme/app_text_styles.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/core/utils/app_formatter.dart';
import 'package:fondo_btg/widgets/shared/card_component.dart';
import 'package:fondo_btg/widgets/shared/custom_button.dart';

class AvailableBalanceCard extends ConsumerWidget {

  const AvailableBalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(userBalanceProvider).availableBalance;
    return SizedBox(
      width: double.infinity,
      child: CardComponent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo disponible',
              style: context.textStyles.bodyLarge?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            _buildResponsive(context,
              children: [
                Text(
                  AppFormatter.formatCurrency(balance),
                  style: AppTextStyles.currency.copyWith(
                    color: context.primary,
                  ),
                ),
                const SizedBox(height: 8),
                CustomButton(
                  context: context,
                  onPressed: () {
                    final currentBalance = ref.read(userBalanceProvider).availableBalance;
                    ref.read(userBalanceProvider.notifier).state =
                        UserBalance(availableBalance: currentBalance + AppConstants.depositAmount);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, size: 18),
                      const SizedBox(width: 4),
                      Text('Depositar'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsive(BuildContext context, {required List<Widget> children}) {
    return context.isMobile
      ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: children,
      )
      : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      );
  }
}