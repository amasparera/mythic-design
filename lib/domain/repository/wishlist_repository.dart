import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/product.dart';
import '../enities/wishlist.dart';

abstract class WishlistRepository{
  Future<Either<Failure,String>>wishlistAdd(String idUser,Product product);
  Future<Either<Failure,String>>wishlistDelete(String idwish);
  Future<Either<Failure,List<Wishlist>>>wishlistGet(String idUser);
}