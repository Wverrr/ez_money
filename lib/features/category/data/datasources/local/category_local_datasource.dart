
import '../../../../../core/database/database.dart';
import '../../models/category_model.dart';


abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getAllCategories();
  Future<CategoryModel> getCategory(int id);
  Future<void> insertCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
  Future<void> deleteCategory(int id);

  Future<List<CategoryModel>> getCategoriesByType(int type);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final AppDb database;

  CategoryLocalDataSourceImpl(this.database);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final categories = await database.select(database.categories).get();
    return categories.map((category) => CategoryModel.fromDb(category)).toList();
  }

  @override
  Future<CategoryModel> getCategory(int id) async {
    final category = await (database.select(database.categories)
      ..where((tbl) => tbl.id.equals(id))).getSingle();
    return CategoryModel.fromDb(category);
  }

  @override
  Future<void> insertCategory(CategoryModel category) async {
    await database.into(database.categories).insert(category.toCompanion(isInsert: true));
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    await (database.update(database.categories)
          ..where((tbl) => tbl.id.equals(category.id)))
        .write(category.toCompanion());
  }

  @override
  Future<void> deleteCategory(int id) async {
    await (database.delete(database.categories)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<List<CategoryModel>> getCategoriesByType(int type) async {
    final categories = await (database.select(database.categories)
      ..where((tbl) => tbl.type.equals(type))).get();
    return categories.map((category) => CategoryModel.fromDb(category)).toList();
  }
}