  import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
  Future<Either<Failure, CategoryEntity>> getCategory(int id);
  Future<Either<Failure, void>> insertCategory(CategoryEntity category);
  Future<Either<Failure, void>> updateCategory(CategoryEntity category);
  Future<Either<Failure, void>> deleteCategory(int id);

  Future<Either<Failure, void>> insertDefaultCategories();
  Future<Either<Failure, List<CategoryEntity>>> getCategoriesByType(int type);
}

