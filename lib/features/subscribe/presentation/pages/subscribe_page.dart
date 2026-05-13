import 'package:flutter/material.dart';

import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/domain/entities/fund.dart';
import 'package:fondo_btg/features/subscribe/presentation/widgets/subscribe_form.dart';
import 'package:hugeicons/hugeicons.dart';

void openSubscribe(BuildContext context, Fund fund) {
  if (context.isMobile) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _SubscribePage(fund: fund),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SubscribeForm(
            fund: fund,
            onSuccess: () {
              Navigator.of(context, rootNavigator: true).pop();
              context.showSnackBar('Suscripción exitosa.');
            },
          ),
        ),
      ),
    );
  }
}

class _SubscribePage extends StatelessWidget {
  final Fund fund;

  const _SubscribePage({required this.fund});

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
        child: SubscribeForm(
          fund: fund,
          onSuccess: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}