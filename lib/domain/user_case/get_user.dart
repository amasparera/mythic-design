import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/user.dart';
import '../repository/user_repository.dart';

class GetUser {
  final UserRepository userRepository;

  GetUser({required this.userRepository});

  Future<Either<Failure, User>> execute({required String id}) {
    return userRepository.getUser(userId: id);
  }
}
