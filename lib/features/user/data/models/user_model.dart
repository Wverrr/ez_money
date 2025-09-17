import 'package:drift/drift.dart';

import '../../../../core/database/database.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {

  const UserModel({
    required super.id,
    required super.name,
    required super.balance,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromDb(User user) {
    return UserModel(
      id: user.id,
      name: user.name ?? 'User',
      balance: user.balance,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  UsersCompanion toCompanion({bool isInsert = false}) {
    return UsersCompanion(
      id: isInsert ? const Value.absent() : Value(id!),
      name: Value(name),
      balance: Value(balance),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      balance: entity.balance,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      balance: balance,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "balance": balance,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? 'User',
      balance: (json['balance'] as num).toDouble(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }
}