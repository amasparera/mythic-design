import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/product_media_image.dart';
import '../repository/creator_repository.dart';

class GetCreatorCollection {
  final CreatorRepository creatorRepository;

  GetCreatorCollection(this.creatorRepository);

  Future<Either<Failure,List<ProductMediaImage>>> execute(String id){
    return creatorRepository.getCreatorCollection(id);
  }
}