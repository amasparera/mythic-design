import 'dart:io';


import 'package:dartz/dartz.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/enities/user.dart';
import '../../domain/repository/user_repository.dart';
import '../datasources/user_remote_db.dart';

class UserRepositoryImpl implements UserRepository{
final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});


  @override
  Future<Either<Failure, User>> getUser({required String userId})async {
    try {
      final result = await userRemoteDataSource.getUser(userId: userId);
      return Right(result.toEntity());
   } on DatabaseException catch(e) {
      return  Left(FailureDatabase(e.message!));
    } on ServerException catch(e) {
      return  Left(FailureServer(e.message!));
    } on SocketException catch(e) {
      return  Left(FailureConnection(e.message));
    }
  }
}