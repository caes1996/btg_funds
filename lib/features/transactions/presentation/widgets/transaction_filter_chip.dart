import 'package:flutter/material.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/features/transactions/presentation/pages/transactions_page.dart';

class TransactionFilterChip extends StatelessWidget {
  final String label;
  final TransactionFilter filter;
  final TransactionFilter selectedFilter;
  final VoidCallback onTap;

  const TransactionFilterChip({
    super.key,
    required this.label,
    required this.filter,
    required this.selectedFilter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedFilter == filter;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary
              : context.colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? context.colors.primary
                : context.colors.onSurface.withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          label,
          style: context.textStyles.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isSelected
                ? context.colors.onPrimary
                : context.colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}