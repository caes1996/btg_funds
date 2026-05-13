import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fondo_btg/core/providers/theme_provider.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';

class CardComponent extends ConsumerWidget {
  const CardComponent({super.key, required this.child, this.onPressed});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkProvider);
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.colors.outlineVariant.withValues(alpha: 0.2),
            ),
            color: context.colors.surfaceContainer,
            boxShadow: [
              BoxShadow(
                color: isDark
                  ? Colors.black.withValues(alpha: 0.15)
                  : Colors.grey.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}