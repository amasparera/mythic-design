import 'package:equatable/equatable.dart';
import '../../domain/enities/product.dart';
import '../../domain/enities/product_media_image.dart';
import 'product_media_image_model.dart';

class ProductModel extends Equatable {
  final int productId;
  final String productName;
  final String productImage;
  final int productPrice;
  final String productCreate;
  final int creatorId;
  final String creatorName;
  final String creatorImage;
  final int? totalBuy;
  final int? totalFavorite;
  final String? description;
  final List<ProductMediaImageModel>? listMediaImage;

  const ProductModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productCreate,
    required this.creatorId,
    required this.creatorName,
    required this.creatorImage,
    this.totalBuy,
    this.totalFavorite,
    this.description,
    this.listMediaImage,
  });

  factory ProductModel.fromjson(Map<String, dynamic> map, image) {
    return ProductModel(
        productId: map["productId"],
        productName: map["productTilte"],
        productImage: map["productCover"],
        productPrice: map["productPrice"],
        productCreate: map["creatAt"],
        creatorId: map["creatorId"],
        creatorName: map["creatorName"],
        creatorImage: map["creatorImage"],
        description: map["productDescription"] ?? "",
        totalBuy: map["productBuy"],
        totalFavorite: map["productLove"],
        listMediaImage: image != null
            ? (image as List<dynamic>)
                .map((e) => ProductMediaImageModel.fromjson(e))
                .toList()
            : null);
  }

  Product toEntity() {
    return Product(
        productId.toString(),
        productName,
        productImage,
        productPrice,
        productCreate,
        creatorId.toString(),
        creatorName,
        creatorImage,
        description: description,
        totalBuy: totalBuy,
        totalFavorite: totalFavorite,
        listMediaImage: listMediaImage != null
            ? listMediaImage!
                .map((e) => ProductMediaImage(
                    id: e.id.toString(),
                    productId: e.productId,
                    image: e.image,
                    creatorId: ''))
                .toList()
            : null);
  }

  @override
  List<Object?> get props => [
        productId,
        productImage,
        productImage,
        productName,
        productCreate,
        creatorId,
        creatorImage,
        creatorName
      ];
}
