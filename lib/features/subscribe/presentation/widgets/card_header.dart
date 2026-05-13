import 'package:flutter/material.dart';
import 'package:fondo_btg/core/theme/app_text_styles.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/core/utils/app_formatter.dart';
import 'package:fondo_btg/domain/entities/fund.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
    required this.fund,
    required this.balance,
  });

  final Fund fund;
  final int balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8)
      ),
      child: _buildResponsive(context,
        children: [
          _buildInfoFund(context),
          _buildBalance(context)
        ],
      ),
    );
  }

  Widget _buildBalance(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Saldo actual disponible',
          style: context.textStyles.bodyMedium,
        ),
        Text(AppFormatter.formatCurrency(balance),
          style: AppTextStyles.currency,
        )
      ],
    );
  }

  Widget _buildInfoFund(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 8,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.isMobile ? 8 : 12,
                vertical: context.isMobile ? 2 : 4
              ),
              decoration: BoxDecoration(
                color: fund.category == FundCategory.FIC ? context.ficBadgeColor : context.fpvBadgeColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(fund.category.name, style: context.textStyles.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white
              )),
            ),
            Text(
              fund.name,
              style: context.isMobile ? context.textStyles.titleSmall : context.textStyles.headlineLarge
            )
          ],
        ),
        Text.rich(
          TextSpan(
            text: 'Inversión mínima: ',
            style: context.textStyles.bodyMedium,
            children: [
              TextSpan(text: AppFormatter.formatCurrency(fund.minimumAmount), style: AppTextStyles.currencySmall),
            ]
          )
        )
      ],
    );
  }

  Widget _buildResponsive(BuildContext context, {required List<Widget> children}) {
    return context.isMobile
      ? Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      )
      : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      );
  }
}