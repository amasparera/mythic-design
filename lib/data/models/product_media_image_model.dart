import 'package:equatable/equatable.dart';

import '../../domain/enities/product_media_image.dart';

class ProductMediaImageModel extends Equatable {
  final int id;

  final String creatorId;
  final String productId;
  final String image;

  const ProductMediaImageModel(
      {required this.id,
      required this.creatorId,
      required this.productId,
      required this.image});

  factory ProductMediaImageModel.fromjson(
      Map<String, dynamic> map) {
    return ProductMediaImageModel(
      id: map["idImage"],
      creatorId: map["idCreator"],
      productId: map["idProduct"],
      image: map["imageUrl"],
    );
  }

  ProductMediaImage toEnities() {
    return ProductMediaImage(
        id: id.toString(),
        creatorId: creatorId,
        productId: productId,
        image: image);
  }

  @override
  List<Object?> get props => [id, productId, image];
}
