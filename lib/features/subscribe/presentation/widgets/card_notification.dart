import 'package:flutter/material.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/domain/entities/transaction.dart';
import 'package:hugeicons/hugeicons.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({
    super.key,
    required this.method,
    required this.title,
    required this.description,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  final NotificationMethod method;
  final String title;
  final String description;
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(context.isMobile ? 16 : 24),
        decoration: BoxDecoration(
          color: isSelected 
              ? context.colors.primary.withValues(alpha: 0.08) 
              : Colors.transparent,
          border: Border.all(
            color: isSelected 
                ? context.colors.primary 
                : context.colors.onSurface.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.isMobile ? 16 : 20,
              height: context.isMobile ? 16 : 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? context.colors.primary : context.colors.onSurface.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: isSelected 
                ? Center(
                    child: Container(
                      width: context.isMobile ? 8 : 10,
                      height: context.isMobile ? 8 : 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colors.primary,
                      ),
                    ),
                  )
                : null,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      HugeIcon(
                        icon: method == NotificationMethod.EMAIL 
                            ? HugeIcons.strokeRoundedMail01 
                            : HugeIcons.strokeRoundedSmartPhone01, 
                        size: 20,
                        color: isSelected ? context.colors.primary : context.colors.onSurface,
                      ),
                      Expanded(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: context.textStyles.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? context.colors.primary : context.colors.onSurface,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyles.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyles.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}