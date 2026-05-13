import 'package:flutter/material.dart';
import 'package:fondo_btg/core/constants/app_constants.dart';
import 'package:fondo_btg/core/theme/app_text_styles.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/core/utils/app_formatter.dart';
import 'package:hugeicons/hugeicons.dart';

class AmountField extends StatelessWidget {
  const AmountField({super.key,
    required this.controller,
    required this.minimumAmount,
    required this.availableBalance,
    this.error
  });

  final TextEditingController controller;
  final String? error;
  final int minimumAmount;
  final int availableBalance;

  (bool, String) getMessage(String text) {
    final textValue = text.replaceAll(RegExp(r'[^\d]'), '');
    final amount = int.tryParse(textValue);
    bool isError = false;
    String internalMessage = '';
    if (textValue.isNotEmpty && amount != null) {
      if (amount > availableBalance) {
        internalMessage = 'El monto excede su saldo disponible.';
        isError = true;
      } else if (amount < minimumAmount) {
        internalMessage = 'Monto mínimo de inversión: ${AppFormatter.formatCurrencySimple(minimumAmount)}';
      } else {
        internalMessage = 'El monto ingresado es válido y está dentro de su saldo.';
      }
    }
    return (isError, internalMessage);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        
        final internalMessage = getMessage(value.text);

        final errorToShow = error ?? (internalMessage.$1 ? internalMessage.$2 : null);
        final showInfo = !internalMessage.$1 && internalMessage.$2.isNotEmpty && error == null;

        return Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monto a invertir (${AppConstants.currencySymbol})',
              style: context.textStyles.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            _buildTextField(context, errorToShow),
            if (showInfo)
              _buildMessage(context, internalMessage.$2),
          ],
        );
      },
    );
  }

  Widget _buildTextField(BuildContext context, String? errorToShow) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: AppTextStyles.currencySmall,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedMoney01,
            color: context.colors.onSurface.withValues(alpha: 0.5),
            size: 24,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        hintText: AppFormatter.formatCurrencySimple(minimumAmount),
        hintStyle: AppTextStyles.currencySmall.copyWith(
          color: context.colors.onSurface.withValues(alpha: .3),
        ),
        errorText: errorToShow,
      ),
    );
  }

  Widget _buildMessage(BuildContext context, String internalMessage) {
    return Row(
      spacing: 6,
      children: [
        Icon(
          Icons.info_outline,
          size: 14,
          color: context.colors.onSurfaceVariant,
        ),
        Expanded(
          child: Text(
            internalMessage,
            style: context.textStyles.bodySmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}