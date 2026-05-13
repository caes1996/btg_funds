import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fondo_btg/core/providers/app_state.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/core/utils/app_formatter.dart';
import 'package:fondo_btg/domain/entities/active_subscription.dart';
import 'package:fondo_btg/domain/entities/fund.dart';
import 'package:fondo_btg/domain/entities/transaction.dart';
import 'package:fondo_btg/domain/entities/user_balance.dart';
import 'package:fondo_btg/features/subscribe/presentation/widgets/amount_field.dart';
import 'package:fondo_btg/features/subscribe/presentation/widgets/card_header.dart';
import 'package:fondo_btg/features/subscribe/presentation/widgets/card_notification.dart';
import 'package:fondo_btg/widgets/shared/card_component.dart';
import 'package:fondo_btg/widgets/shared/custom_button.dart';
import 'package:hugeicons/hugeicons.dart';

class SubscribeForm extends ConsumerStatefulWidget {
  const SubscribeForm({super.key, required this.fund, this.onSuccess});
  
  final Fund fund;
  final VoidCallback? onSuccess;

  @override
  ConsumerState<SubscribeForm> createState() => _SubscribeFormState();
}

class _SubscribeFormState extends ConsumerState<SubscribeForm> {
  late final TextEditingController _amountController;
  late List<NotificationMethod> _selectedMethods;
  bool _isSubmitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _selectedMethods = [];
    
    // Clear external error when user types to show live validation
    _amountController.addListener(() {
      if (_error != null) {
        setState(() => _error = null);
      }
    });
  }

  void _toggleNotificationMethod(NotificationMethod method) {
    setState(() {
      if (_selectedMethods.contains(method)) {
        _selectedMethods.remove(method);
      } else {
        _selectedMethods.add(method);
      }
    });
  }

  Fund get fund => widget.fund;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  int? get _parsedAmount {
    final text = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    if (text.isEmpty) return null;
    return int.tryParse(text);
  }

  String? _validateAmount(int? amount) {
    if (amount == null) return 'Ingresa un monto';
    if (amount < fund.minimumAmount) {
      return 'Monto mínimo: ${AppFormatter.formatCurrency(fund.minimumAmount)}';
    }
    final balance = ref.read(userBalanceProvider).availableBalance;
    if (amount > balance) {
      return 'Saldo insuficiente. Disponible: ${AppFormatter.formatCurrency(balance)}';
    }
    return null;
  }

  void _submit() {
    final amount = _parsedAmount;
    final error = _validateAmount(amount);

    if (error != null) {
      setState(() => _error = error);
      return;
    }

    if (isSubscribedTo(ref, fund.id)) {
      setState(() => _error = 'Ya estás suscrito a este fondo');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _error = null;
    });

    final balance = ref.read(userBalanceProvider).availableBalance;

    ref.read(userBalanceProvider.notifier).state = UserBalance(availableBalance: balance - amount!);

    ref.read(subscriptionsProvider.notifier).state = [
      ...ref.read(subscriptionsProvider),
      ActiveSubscription(
        fundId: fund.id,
        investedAmount: amount,
        subscribedAt: DateTime.now(),
      ),
    ];

    ref.read(transactionsProvider.notifier).state = [
      Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: TransactionType.SUBSCRIBE,
        fundId: fund.id,
        fundName: fund.name,
        amount: amount,
        date: DateTime.now(),
        notificationMethod: _selectedMethods.isNotEmpty 
            ? _selectedMethods.first 
            : NotificationMethod.EMAIL,
      ),
      ...ref.read(transactionsProvider),
    ];

    setState(() => _isSubmitting = false);

    widget.onSuccess?.call();
  }

  @override
  Widget build(BuildContext context) {
    return context.isMobile
      ? _buildContent()
      : CardComponent(child: _buildContent());
  }

  Widget _buildContent() {
    final balance = ref.watch(userBalanceProvider).availableBalance;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardHeader(fund: fund, balance: balance),
        const SizedBox(height: 36),
        AmountField(
          controller: _amountController,
          error: _error,
          minimumAmount: fund.minimumAmount,
          availableBalance: balance,
        ),
        const SizedBox(height: 36),
        Text('Preferencias de Notificación', style: context.textStyles.displaySmall),
        const Divider(),
        const SizedBox(height: 12),
        _buildResponsive(context,
          children: [
            CardNotification(
              method: NotificationMethod.EMAIL,
              title: 'Correo Electrónico',
              description: 'Recibir confirmación en',
              value: 'user@email.com',
              isSelected: _selectedMethods.contains(NotificationMethod.EMAIL),
              onTap: () => _toggleNotificationMethod(NotificationMethod.EMAIL),
            ),
            CardNotification(
              method: NotificationMethod.SMS,
              title: 'SMS',
              description: 'Recibir alerta al +57 *** ***',
              value: '1234',
              isSelected: _selectedMethods.contains(NotificationMethod.SMS),
              onTap: () => _toggleNotificationMethod(NotificationMethod.SMS),
            )
          ],
        ),
        const SizedBox(height: 32),
        CustomButton(context: context,
        onPressed: _isSubmitting ? null : _submit,
          child: Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Confirmar suscripción'),
              HugeIcon(icon: HugeIcons.strokeRoundedCheckmarkCircle01, size: 20)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResponsive(BuildContext context, {required List<Widget> children}) {
    return context.isMobile
      ? Column(
        spacing: 16,
        children: children,
      )
      : Row(
        spacing: 16,
        children: children.map((c) => Flexible(child: c)).toList(),
      );
  }
}