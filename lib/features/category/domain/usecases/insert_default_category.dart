import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/category_repository.dart';

class InsertDefaultCategory {
  final CategoryRepository categoryRepository;

  InsertDefaultCategory(this.categoryRepository);

  Future<Either<Failure, void>> execute() async {
    return await categoryRepository.insertDefaultCategories();
  }
}
