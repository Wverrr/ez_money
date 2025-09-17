class SavingEntity {
  final int id;
  final int userId;
  final String name;
  final double targetAmount;
  final double currentAmount;
  final int status; // 1: Active, 2: Completed
  final DateTime createdAt;
  final DateTime updatedAt;

  SavingEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}