import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String name;
  final double balance;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    this.id,
    required this.name,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [id, name, balance, createdAt, updatedAt];
  }
}
