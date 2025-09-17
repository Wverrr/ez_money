import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final int type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      type,
      createdAt,
      updatedAt,
    ];
  }
}
