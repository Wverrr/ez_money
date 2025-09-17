import 'package:drift/drift.dart';

import '../../../../core/database/database.dart';
import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  // final int id;
  // final String name;
  // final int type;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  const CategoryModel({
    required super.id,
    required super.name,
    required super.type,
    required super.createdAt,
    required super.updatedAt,
  });

  // 🔁 Convert from Drift Table (Category from DB)
  factory CategoryModel.fromDb(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      type: category.type,
      createdAt: category.createdAt,
      updatedAt: category.updatedAt,
    );
  }

  // 🔁 Convert to Drift Companion (untuk insert/update ke DB)
  CategoriesCompanion toCompanion({bool isInsert = false}) {
    return CategoriesCompanion(
      id: isInsert ? const Value.absent() : Value(id),
      name: Value(name),
      type: Value(type),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // CategoryEntity toEntity() {
  //   return CategoryEntity(
  //     id: id,
  //     name: name,
  //     type: type,
  //     createdAt: createdAt,
  //     updatedAt: updatedAt,
  //   );
  // }
}
