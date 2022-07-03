import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({required int page});
  Future<Either<Failure, Product>> getProductDetail({required String productId});
}
