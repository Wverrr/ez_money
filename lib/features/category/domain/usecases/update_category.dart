import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class UpdateCategory {
  final CategoryRepository categoryRepository;

  UpdateCategory(this.categoryRepository);
  
  Future<Either<Failure, void>> execute(CategoryEntity category) async {
    return await categoryRepository.updateCategory(category);
  }
}
