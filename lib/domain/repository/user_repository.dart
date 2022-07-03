import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser({required String userId});
}