class TransactionItem {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final bool isIncome;

  TransactionItem({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}
