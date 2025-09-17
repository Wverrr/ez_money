import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetLastActiveUser {
  final UserRepository userRepository;

  GetLastActiveUser(this.userRepository);

  Future<Either<Failure, UserEntity>> execute() async {
    return await userRepository.getLastActiveUser();
  }
}