import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUser {
  final UserRepository userRepository;

  GetUser(this.userRepository);

  Future<Either<Failure, UserEntity>> execute(int id) async {
    return await userRepository.getUser(id);
  }
}