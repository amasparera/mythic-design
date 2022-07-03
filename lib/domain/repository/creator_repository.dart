import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/creator.dart';
import '../enities/product_media_image.dart';

abstract class CreatorRepository {
  Future<Either<Failure,Creator>> getCreator(String id);
  Future<Either<Failure,List<ProductMediaImage>>> getCreatorCollection(String id);
}