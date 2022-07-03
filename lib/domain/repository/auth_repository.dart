import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/user.dart';

abstract class AuthRepository{
  Future<Either<Failure,User>> login({required String email,required String password});
  Future<Either<Failure,User>> singup({required String name, required String email,required String password});
}