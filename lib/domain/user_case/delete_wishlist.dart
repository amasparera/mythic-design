import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../repository/wishlist_repository.dart';

class DeleteWishlist {
  final WishlistRepository wishlistRepository;

  DeleteWishlist(this.wishlistRepository);

  Future<Either<Failure, String>> execute(String idwish) {
    return wishlistRepository.wishlistDelete(idwish);
  }
}
