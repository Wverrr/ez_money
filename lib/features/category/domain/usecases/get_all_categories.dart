import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetAllCategories {
  final CategoryRepository categoryRepository;

  GetAllCategories(this.categoryRepository);
  
  Future<Either<Failure, List<CategoryEntity>>> execute() async {
    return await categoryRepository.getAllCategories();
  }
}
