import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fondo_btg/core/providers/app_state.dart';
import 'package:fondo_btg/core/theme/context_extensions.dart';
import 'package:fondo_btg/core/utils/app_formatter.dart';
import 'package:fondo_btg/domain/entities/transaction.dart';
import 'package:fondo_btg/features/transactions/presentation/widgets/transaction_card.dart';
import 'package:fondo_btg/features/transactions/presentation/widgets/transaction_filter_chip.dart';

enum TransactionFilter { all, subscriptions, cancellations }

class TransactionsPage extends ConsumerStatefulWidget {
  const TransactionsPage({super.key});

  @override
  ConsumerState<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends ConsumerState<TransactionsPage> {
  TransactionFilter _filter = TransactionFilter.all;

  @override
  Widget build(BuildContext context) {
    final allTransactions = ref.watch(transactionsProvider);

    final filtered = allTransactions.where((t) {
      if (_filter == TransactionFilter.all) return true;
      if (_filter == TransactionFilter.subscriptions) return t.type == TransactionType.SUBSCRIBE;
      if (_filter == TransactionFilter.cancellations) return t.type == TransactionType.CANCEL;
      return true;
    }).toList();

    filtered.sort((a, b) => b.date.compareTo(a.date));

    final grouped = _groupTransactions(filtered);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Historial de transacciones', style: context.textStyles.displaySmall),
        const SizedBox(height: 8),
        Text('Revisa el detalle de tus movimientos recientes.',
            style: context.textStyles.bodyLarge?.copyWith(
                color: context.colors.onSurfaceVariant)),
        const SizedBox(height: 24),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 12,
            children: [
              TransactionFilterChip(
                label: 'TODAS',
                filter: TransactionFilter.all,
                selectedFilter: _filter,
                onTap: () => setState(() => _filter = TransactionFilter.all),
              ),
              TransactionFilterChip(
                label: 'SUSCRIPCIONES',
                filter: TransactionFilter.subscriptions,
                selectedFilter: _filter,
                onTap: () => setState(() => _filter = TransactionFilter.subscriptions),
              ),
              TransactionFilterChip(
                label: 'CANCELACIONES',
                filter: TransactionFilter.cancellations,
                selectedFilter: _filter,
                onTap: () => setState(() => _filter = TransactionFilter.cancellations),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        if (filtered.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                'No tienes transacciones aún.',
                style: context.textStyles.bodyLarge?.copyWith(
                    color: context.colors.onSurfaceVariant),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: grouped.length,
              itemBuilder: (context, index) {
                final dateKey = grouped.keys.elementAt(index);
                final items = grouped[dateKey]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dateKey, style: context.textStyles.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ...items.map((t) => TransactionCard(transaction: t)),
                    const SizedBox(height: 24),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }

  Map<String, List<Transaction>> _groupTransactions(List<Transaction> transactions) {
    final Map<String, List<Transaction>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final t in transactions) {
      final tDate = DateTime(t.date.year, t.date.month, t.date.day);
      String key;
      if (tDate == today) {
        key = 'Hoy';
      } else if (tDate == yesterday) {
        key = 'Ayer';
      } else {
        key = AppFormatter.formatDate(t.date);
      }
      grouped.putIfAbsent(key, () => []).add(t);
    }
    return grouped;
  }
}