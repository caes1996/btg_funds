enum TransactionType { SUBSCRIBE, CANCEL }

enum NotificationMethod { EMAIL, SMS }

class Transaction {
  final String id;
  final TransactionType type;
  final String fundId;
  final String fundName;
  final int amount;
  final DateTime date;
  final NotificationMethod? notificationMethod;

  const Transaction({
    required this.id,
    required this.type,
    required this.fundId,
    required this.fundName,
    required this.amount,
    required this.date,
    this.notificationMethod,
  });
}