import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/wishlist.dart';
import '../repository/wishlist_repository.dart';

class GetWislist{
  final WishlistRepository wishlistRepository;

  GetWislist(this.wishlistRepository);


  Future<Either<Failure,List<Wishlist>>> execute(String idWishlist){
    return  wishlistRepository.wishlistGet(idWishlist);


  }
}