import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class InsertUser {
  final UserRepository userRepository;

  InsertUser(this.userRepository);

  Future<Either<Failure, void>> execute(UserEntity user) async {
    return await userRepository.insertUser(user);
  }
}