
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/category_repository.dart';

class DeleteCategory {
  final CategoryRepository categoryRepository;

  DeleteCategory(this.categoryRepository);
  
  Future<Either<Failure, void>> execute(int id) async {
    return await categoryRepository.deleteCategory(id);
  }
}
