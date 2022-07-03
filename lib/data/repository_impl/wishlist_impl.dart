import 'dart:io';


import 'package:dartz/dartz.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/enities/product.dart';
import '../../domain/enities/wishlist.dart';
import '../../domain/repository/wishlist_repository.dart';
import '../datasources/wishlist_remote.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteSource wishlistRemoteSource;

  WishlistRepositoryImpl(this.wishlistRemoteSource);
  @override
  Future<Either<Failure, String>> wishlistAdd(
      String idUser, Product product) async {
    try {
      final result = await wishlistRemoteSource.wishlistAdd({
        "idUser": idUser,
        "idProduct": product.productId,
        "image": product.productImage,
        "title": product.productName,
        "price" :product.productPrice.toString()
      });
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(FailureDatabase(e.message!));
    } on ServerException catch (e) {
      return Left(FailureServer(e.message!));
    } on SocketException catch (e) {
      return Left(FailureConnection(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> wishlistDelete(String idwish) async {
    try {
      final result = await wishlistRemoteSource.wishlistDelete(idwish);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(FailureDatabase(e.message!));
    } on ServerException catch (e) {
      return Left(FailureServer(e.message!));
    } on SocketException catch (e) {
      return Left(FailureConnection(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Wishlist>>> wishlistGet(String idUser)async {
  try {
      final result = await wishlistRemoteSource.wishlistRead(idUser);
      return Right(result.map((e) => e.toEnities()).toList());
   } on DatabaseException catch(e) {
      return  Left(FailureDatabase(e.message!));
    } on ServerException catch(e) {
      return  Left(FailureServer(e.message!));
    } on SocketException catch(e) {
      return  Left(FailureConnection(e.message));
    }
  }
}
