import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/local/category_local_datasource.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      final result = await localDataSource.getAllCategories();
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to load categories'));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategory(int id) async {
    try {
      final result = await localDataSource.getCategory(id);
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to load category'));
    }
  }

  @override
  Future<Either<Failure, void>> insertCategory(CategoryEntity category) async {
    try {
      await localDataSource.insertCategory(CategoryModel.fromEntity(category));
      return const Right(null);
    } catch (e) {
      print(e);
      return Left(Failure('Failed to insert category'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCategory(CategoryEntity category) async {
    try {
      await localDataSource.updateCategory(CategoryModel.fromEntity(category));
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to update category'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(int id) async {
    try {
      await localDataSource.deleteCategory(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to delete category'));
    }
  }

  @override
  Future<Either<Failure, void>> insertDefaultCategories() async {
    final existing = await localDataSource.getAllCategories();
    try {
      if (existing.isEmpty) {
        await localDataSource.insertCategory(
          CategoryModel.fromEntity(
            CategoryEntity(
              id: 1,
              name: "Makanan",
              type: 2,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
        );
        await localDataSource.insertCategory(
          CategoryModel.fromEntity(
            CategoryEntity(
              id: 2,
              name: "Transportasi",
              type: 2,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
        );
        await localDataSource.insertCategory(
          CategoryModel.fromEntity(
            CategoryEntity(
              id: 3,
              name: "Gaji",
              type: 1,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to insert default categories'));
    }
  }
  
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategoriesByType(int type) async {
    try {
      final result = await localDataSource.getCategoriesByType(type);
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to load categories by type'));
    }
  }
}
