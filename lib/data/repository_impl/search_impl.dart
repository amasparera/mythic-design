import 'dart:io';


import 'package:dartz/dartz.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../common/tipe_search.dart';
import '../../domain/enities/product_media_image.dart';
import '../../domain/repository/search_repository.dart';
import '../datasources/search_remote.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRepositoryImpl(this.searchRemoteDataSource);
  @override
  Future<Either<Failure, List<ProductMediaImage>>> searchProduct(
      {TypeSearch? typeSearch, String? text}) async {
    try {
      switch (typeSearch) {
        case TypeSearch.cosplay:
          final result = await searchRemoteDataSource.searchCosplay();
          return Right(result.map((e) => e.toEnities()).toList());
        case TypeSearch.highPrice:
          final result = await searchRemoteDataSource.searchHighPrice();
          return Right(result.map((e) => e.toEnities()).toList());
        case TypeSearch.lowPrice:
          final result = await searchRemoteDataSource.searchLowPrice();
          return Right(result.map((e) => e.toEnities()).toList());
        case TypeSearch.illustration:
          final result = await searchRemoteDataSource.searchIlustration();
          return Right(result.map((e) => e.toEnities()).toList());
        case TypeSearch.populer:
          final result = await searchRemoteDataSource.searchPopular();
          return Right(result.map((e) => e.toEnities()).toList());
        case TypeSearch.productNew:
          final result = await searchRemoteDataSource.searchNew();
          return Right(result.map((e) => e.toEnities()).toList());
        
        default:
          final result = await searchRemoteDataSource.searchProduct(text!);
          return Right(result.map((e) => e.toEnities()).toList());
      }
    } on DatabaseException catch (e) {
      return Left(FailureDatabase(e.message!));
    } on ServerException catch (e) {
      return Left(FailureServer(e.message!));
    } on SocketException catch (e) {
      return Left(FailureConnection(e.message));
    }
  }
}
