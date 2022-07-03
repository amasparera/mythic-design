import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/product.dart';
import '../repository/product_repository.dart';

class GetProductDetail {
  final ProductRepository productRepository;

  GetProductDetail(this.productRepository);

  Future<Either<Failure,Product>> execute({required String productId}){
    return  productRepository.getProductDetail(productId: productId);
  }
}