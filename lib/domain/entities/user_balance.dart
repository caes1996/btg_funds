import 'package:fondo_btg/domain/entities/active_subscription.dart';

class UserBalance {
  final int availableBalance;
  final List<ActiveSubscription> activeSubscriptions;

  const UserBalance({
    required this.availableBalance,
    this.activeSubscriptions = const []
  });

  UserBalance copyWith({int? availableBalance, List<ActiveSubscription>? activeSubscriptions}) => UserBalance(
    availableBalance: availableBalance ?? this.availableBalance,
    activeSubscriptions: activeSubscriptions ?? this.activeSubscriptions
  );
}
