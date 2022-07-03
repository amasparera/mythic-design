import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../../common/tipe_search.dart';
import '../enities/product_media_image.dart';
import '../repository/search_repository.dart';

class SearchProductUseCase{
  final SearchRepository searchRepository;

  SearchProductUseCase(this.searchRepository);

  Future<Either<Failure,List<ProductMediaImage>>> execute({String? text,required TypeSearch typeSearch})async{
    return searchRepository.searchProduct(typeSearch: typeSearch,text: text);
  }
}