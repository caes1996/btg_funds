import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fondo_btg/core/providers/app_state.dart';
import 'package:fondo_btg/core/theme/app_colors.dart';
import 'package:fondo_btg/core/theme/app_text_styles.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/core/utils/app_formatter.dart';
import 'package:fondo_btg/domain/entities/active_subscription.dart';
import 'package:fondo_btg/domain/entities/fund.dart';
import 'package:fondo_btg/domain/entities/transaction.dart';
import 'package:fondo_btg/domain/entities/user_balance.dart';
import 'package:fondo_btg/widgets/shared/card_component.dart';
import 'package:fondo_btg/widgets/shared/custom_button.dart';
import 'package:hugeicons/hugeicons.dart';

class CancelSubscribeCard extends ConsumerStatefulWidget {
  const CancelSubscribeCard({
    super.key,
    required this.fund,
    required this.subscription,
    this.onConfirm,
  });

  final Fund fund;
  final ActiveSubscription subscription;
  final VoidCallback? onConfirm;

  @override
  ConsumerState<CancelSubscribeCard> createState() =>
      _CancelSubscribeCardState();
}

class _CancelSubscribeCardState extends ConsumerState<CancelSubscribeCard> {
  @override
  Widget build(BuildContext context) {
    return context.isMobile
        ? _buildContent()
        : CardComponent(child: _buildContent());
  }

  Widget _buildContent() {
    return Column(
      spacing: 16,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Resumen de inversión', style: context.textStyles.headlineSmall),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            spacing: 12,
            children: [
              _buildRowContent(
                label: 'Fondo',
                child: Text(widget.fund.name,
                    textAlign: TextAlign.end,
                    style: context.textStyles.titleSmall),
              ),
              const Divider(),
              _buildRowContent(
                label: 'Categoría',
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.isMobile ? 8 : 12,
                    vertical: context.isMobile ? 2 : 4,
                  ),
                  decoration: BoxDecoration(
                    color: widget.fund.category == FundCategory.FIC
                        ? context.ficBadgeColor
                        : context.fpvBadgeColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(widget.fund.category.name,
                      style: context.textStyles.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
              const Divider(),
              _buildRowContent(
                label: 'Fecha de suscripción',
                child: Text(
                  AppFormatter.formatDate(widget.subscription.subscribedAt),
                  textAlign: TextAlign.end,
                  style: context.textStyles.titleSmall,
                ),
              ),
              const Divider(),
              _buildRowContent(
                label: 'Monto invertido',
                child: Text(
                  AppFormatter.formatCurrency(widget.subscription.investedAmount),
                  textAlign: TextAlign.end,
                  style: AppTextStyles.currencySmall,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            spacing: 12,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedAlertCircle,
                color: context.colors.primary,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(
                      text: 'Se reintegrarán ',
                      style: context.textStyles.bodyMedium,
                      children: [
                        TextSpan(
                          text: AppFormatter.formatCurrency(
                              widget.subscription.investedAmount),
                          style: AppTextStyles.currencySmall.copyWith(
                            color: context.colors.primary,
                          ),
                        ),
                        const TextSpan(text: ' a tu saldo disponible'),
                      ],
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 2),
        CustomButton(
          context: context,
          onPressed: _handleCancel,
          color: AppColors.error,
          colorText: AppColors.background,
          label: 'Confirmar cancelación',
        )
      ],
    );
  }

  void _handleCancel() {
    final balance = ref.read(userBalanceProvider).availableBalance;
    ref.read(userBalanceProvider.notifier).state = UserBalance(
      availableBalance: balance + widget.subscription.investedAmount,
    );

    ref.read(subscriptionsProvider.notifier).state = ref
        .read(subscriptionsProvider)
        .where((s) => s.fundId != widget.fund.id)
        .toList();

    ref.read(transactionsProvider.notifier).state = [
      Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: TransactionType.CANCEL,
        fundId: widget.fund.id,
        fundName: widget.fund.name,
        amount: widget.subscription.investedAmount,
        date: DateTime.now(),
      ),
      ...ref.read(transactionsProvider),
    ];

    widget.onConfirm?.call();
  }

  Widget _buildRowContent({required String label, required Widget child}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.textStyles.bodyMedium),
        Flexible(child: child),
      ],
    );
  }
}