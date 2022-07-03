import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/product.dart';
import '../repository/product_repository.dart';

class GetProducts {
  final ProductRepository productRepository;

  GetProducts({required this.productRepository});

  Future<Either<Failure, List<Product>>> execute({required int page}) {
    
    return productRepository.getProducts(page: page);
  }
}
