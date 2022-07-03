import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/product.dart';
import '../repository/wishlist_repository.dart';

class AddWishlist {
  final WishlistRepository wishlistRepository;

  AddWishlist(this.wishlistRepository);

  Future<Either<Failure,String>> execute(String idUser,Product product){
    return wishlistRepository.wishlistAdd(idUser, product);
  }
}