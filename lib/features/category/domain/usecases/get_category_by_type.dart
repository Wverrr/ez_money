import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoriesByType {
  final CategoryRepository categoryRepository;

  GetCategoriesByType(this.categoryRepository);

  Future<Either<Failure, List<CategoryEntity>>> execute(int type) async {
    return await categoryRepository.getCategoriesByType(type);
  }
}
