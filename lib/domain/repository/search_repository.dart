import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../common/tipe_search.dart';
import '../enities/product_media_image.dart';

abstract class SearchRepository{
  Future<Either<Failure,List<ProductMediaImage>>> searchProduct({required TypeSearch typeSearch,String? text});
}