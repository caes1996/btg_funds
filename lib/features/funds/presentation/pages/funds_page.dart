import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fondo_btg/core/providers/app_state.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/data/datasources/mock_funds.dart';
import 'package:fondo_btg/features/funds/presentation/widgets/available_balance_card.dart';
import 'package:fondo_btg/features/funds/presentation/widgets/fund_card.dart';
import 'package:fondo_btg/features/subscribe/presentation/pages/cancel_page.dart';
import 'package:fondo_btg/features/subscribe/presentation/pages/subscribe_page.dart';

class FundsPage extends ConsumerWidget {
  const FundsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptions = ref.watch(subscriptionsProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvailableBalanceCard(),
          const SizedBox(height: 24),
          Text('Fondos Disponibles', style: context.textStyles.titleLarge),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mockFunds.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isMobile ? 1 : context.isTablet ? 2 : 3,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: context.isMobile ? 1.9 : context.isTablet ? 1.5 : 1.4,
            ),
            itemBuilder: (context, index) {
              final fund = mockFunds[index];
              final subscription = subscriptions.where((s) => s.fundId == fund.id).firstOrNull;
              final isSubscribed = subscription != null;
              return FundCard(
                fund: fund,
                isSubscribed: isSubscribed,
                investedAmount: subscription?.investedAmount,
                onPressed: isSubscribed
                  ? () => openCancelSubscribe(context, fund, subscription)
                  : () => openSubscribe(context, fund),
              );
            },
          ),
        ],
      ),
    );
  }
}