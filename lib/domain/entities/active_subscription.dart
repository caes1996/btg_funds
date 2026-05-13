class ActiveSubscription {
  final String fundId;
  final int investedAmount;
  final DateTime subscribedAt;

  const ActiveSubscription({
    required this.fundId,
    required this.investedAmount,
    required this.subscribedAt,
  });
}