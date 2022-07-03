import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/user.dart';
import '../repository/auth_repository.dart';

class SingUpAuth {
  final AuthRepository authRepository;

  SingUpAuth(this.authRepository);

  Future<Either<Failure, User>> execute(String name, String email, String password)  {
    return  authRepository.singup(
        name: name, email: email, password: password);
  }
}
