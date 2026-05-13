import 'package:flutter/material.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/core/utils/app_formatter.dart';
import 'package:fondo_btg/data/datasources/mock_funds.dart';
import 'package:fondo_btg/domain/entities/fund.dart';
import 'package:fondo_btg/domain/entities/transaction.dart';
import 'package:hugeicons/hugeicons.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isSubscription = transaction.type == TransactionType.SUBSCRIBE;

    final fund = mockFunds.firstWhere(
      (f) => f.id == transaction.fundId,
      orElse: () => mockFunds.first,
    );
    final isFIC = fund.category == FundCategory.FIC;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
            color: context.colors.onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.colors.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: HugeIcon(
              icon: isSubscription
                  ? HugeIcons.strokeRoundedArrowDown01
                  : HugeIcons.strokeRoundedArrowUp01,
              size: 20,
              color: isSubscription
                  ? context.colors.primary
                  : context.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.fundName,
                    style: context.textStyles.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '${transaction.date.hour.toString().padLeft(2, '0')}:${transaction.date.minute.toString().padLeft(2, '0')}',
                      style: context.textStyles.bodySmall
                          ?.copyWith(color: context.colors.onSurfaceVariant),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text('•',
                          style: context.textStyles.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant)),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isFIC
                            ? context.ficBadgeColor
                            : context.fpvBadgeColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        fund.category.name,
                        style: context.textStyles.labelSmall?.copyWith(
                            color: Colors.white, fontSize: 10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text('•',
                          style: context.textStyles.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant)),
                    ),
                    HugeIcon(
                      icon: transaction.notificationMethod ==
                              NotificationMethod.EMAIL
                          ? HugeIcons.strokeRoundedMail01
                          : HugeIcons.strokeRoundedSmartPhone01,
                      size: 14,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isSubscription ? '-' : '+'} ${AppFormatter.formatCurrencySimple(transaction.amount)}',
                style: context.textStyles.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSubscription
                      ? context.subscribeColor
                      : context.cancelColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isSubscription ? 'Aprobada' : 'Completada',
                style: context.textStyles.bodySmall
                    ?.copyWith(color: context.colors.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}