import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/enities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteRepository authRemoteRepositoryImpl;

  AuthRepositoryImpl(this.authRemoteRepositoryImpl);
  @override
  Future<Either<Failure, User>> login(
      {required String email, required String password}) async {
    Map<String, dynamic> data = {"email": email, "password": password};
    try {
      final result = await authRemoteRepositoryImpl.logIn(map: data);
      return Right(result!.toEntity());
    } on DatabaseException catch(e) {
      return  Left(FailureDatabase(e.message!));
    } on ServerException catch(e) {
      return  Left(FailureServer(e.message!));
    } on SocketException catch(e) {
      return  Left(FailureConnection(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> singup(
      {required String name,
      required String email,
      required String password}) async {
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "password": password
    };
    try {
      final result = await authRemoteRepositoryImpl.singUp(map: data);
      return Right(result!.toEntity());
    } on DatabaseException catch(e) {
      return  Left(FailureDatabase(e.message!));
    } on ServerException catch(e) {
      return  Left(FailureServer(e.message!));
    } on SocketException catch(e) {
      return  Left(FailureConnection(e.message));
    }
  }
}
