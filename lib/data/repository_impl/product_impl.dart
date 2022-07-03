import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/enities/product.dart';
import '../../domain/repository/product_repository.dart';
import '../datasources/product_remote_db.dart';


class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts({required int page}) async {
    
    try {
      final result = await remoteDataSource.getProducts(page: page);
      return Right(result.map((e) => e.toEntity()).toList());
    } on DatabaseException catch(e) {
      return  Left(FailureDatabase(e.message!));
    } on ServerException catch(e) {
      return  Left(FailureServer(e.message!));
    } on SocketException catch(e) {
      return  Left(FailureConnection(e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetail({required String productId}) async {
    try {
      final result = await remoteDataSource.getProductDetail(productId: productId);
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
