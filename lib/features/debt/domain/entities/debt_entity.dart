class DebtEntity {
  final int id;
  final int userId;
  final String name;
  final double totalAmount;
  final double paidAmount;
  final DateTime dueDate;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DebtEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
