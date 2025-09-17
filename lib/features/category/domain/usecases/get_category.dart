import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategory {
  final CategoryRepository categoryRepository;

  GetCategory(this.categoryRepository);
  
  Future<Either<Failure, CategoryEntity>> execute(int id) async {
    return await categoryRepository.getCategory(id);
  }
}
