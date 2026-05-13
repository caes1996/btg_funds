import 'package:flutter/material.dart';
import 'package:fondo_btg/core/theme/app_colors.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/domain/entities/active_subscription.dart';
import 'package:fondo_btg/domain/entities/fund.dart';
import 'package:fondo_btg/features/subscribe/presentation/widgets/cancel_subscribe_card.dart';
import 'package:hugeicons/hugeicons.dart';

void openCancelSubscribe(
    BuildContext context, Fund fund, ActiveSubscription subscription) {
  if (context.isMobile) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            _CancelSubscribePage(fund: fund, subscription: subscription),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                color: AppColors.error.withValues(alpha: 0.2),
                child: Column(
                  children: [
                    const HugeIcon(
                        icon: HugeIcons.strokeRoundedAlert01, size: 30),
                    Text(
                      '¿Estás seguro de cancelar tu participación?',
                      style: context.textStyles.displaySmall,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    Text(
                      'Esta acción no se puede deshacer.',
                      style: context.textStyles.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              CancelSubscribeCard(
                fund: fund,
                subscription: subscription,
                onConfirm: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  context
                      .showSnackBar('Cancelación exitosa. Saldo reintegrado.');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CancelSubscribePage extends StatelessWidget {
  const _CancelSubscribePage(
      {required this.fund, required this.subscription});

  final Fund fund;
  final ActiveSubscription subscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              color: AppColors.error.withValues(alpha: 0.2),
              child: Column(
                children: [
                  const HugeIcon(
                      icon: HugeIcons.strokeRoundedAlert01, size: 30),
                  Text(
                    '¿Estás seguro de cancelar tu participación?',
                    style: context.textStyles.displaySmall,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  Text(
                    'Esta acción no se puede deshacer.',
                    style: context.textStyles.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            CancelSubscribeCard(
              fund: fund,
              subscription: subscription,
              onConfirm: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}