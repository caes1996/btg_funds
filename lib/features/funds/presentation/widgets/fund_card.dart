import 'package:flutter/material.dart';
import 'package:fondo_btg/core/theme/app_text_styles.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/domain/entities/fund.dart';
import 'package:fondo_btg/core/utils/app_formatter.dart';
import 'package:fondo_btg/widgets/shared/card_component.dart';
import 'package:fondo_btg/widgets/shared/custom_button.dart';
import 'package:hugeicons/hugeicons.dart';

class FundCard extends StatelessWidget {
  final Fund fund;
  final bool isSubscribed;
  final int? investedAmount;
  final VoidCallback? onPressed;

  const FundCard({
    super.key,
    required this.fund,
    this.isSubscribed = false,
    this.investedAmount,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CardComponent(
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 12),
          _buildContent(context),
          const Spacer(),
          const Divider(),
          const SizedBox(height: 8),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fund.name,
          style: context.textStyles.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedCash02,
              size: 16,
              color: context.colors.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              'Min: ${AppFormatter.formatCurrencySimple(fund.minimumAmount)}',
              style: context.textStyles.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final badgeColor = fund.category == FundCategory.FPV
      ? context.fpvBadgeColor
      : context.ficBadgeColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            color: badgeColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: badgeColor),
          ),
          child: Text(
            fund.category.name,
            style: context.textStyles.labelSmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        HugeIcon(
          icon: HugeIcons.strokeRoundedPieChart02,
          size: 20,
          color: context.colors.onSurfaceVariant,
        )
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isSubscribed)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TU INVERSIÓN',
                style: context.textStyles.labelSmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              Text(
                AppFormatter.formatCurrencySimple(investedAmount!),
                style: AppTextStyles.currencySmall.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
      else
        const Spacer(),
        CustomButton(
          context: context,
          outlined: isSubscribed,
          label: isSubscribed ? 'Cancelar' : 'Suscribirse',
          onPressed: onPressed,
        ),
      ],
    );
  }
}