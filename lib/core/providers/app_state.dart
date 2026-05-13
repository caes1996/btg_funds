import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/active_subscription.dart';
import '../../domain/entities/transaction.dart';
import 'package:fondo_btg/core/constants/app_constants.dart';
import 'package:fondo_btg/domain/entities/user_balance.dart';

final userBalanceProvider = StateProvider<UserBalance>(
  (ref) => UserBalance(availableBalance: AppConstants.initialBalance),
);

final subscriptionsProvider = StateProvider<List<ActiveSubscription>>((ref) => []);

final transactionsProvider = StateProvider<List<Transaction>>((ref) => []);

bool isSubscribedTo(WidgetRef ref, String fundId) {
  return ref.read(subscriptionsProvider.notifier).state.any(
    (s) => s.fundId == fundId,
  );
}