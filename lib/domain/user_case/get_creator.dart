import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../enities/creator.dart';
import '../repository/creator_repository.dart';

class GetCreator {
  final CreatorRepository creatorRepository;

  GetCreator(this.creatorRepository);

  Future<Either<Failure,Creator>> execute(String id){
    return  creatorRepository.getCreator(id);
  }
}