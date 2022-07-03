import 'package:equatable/equatable.dart';
import 'package:mythicdesign/domain/enities/product_media_image.dart';

class Product extends Equatable {
  final String productId;
  final String productName;
  final String productImage;
  final int productPrice;
  final String creatAt;
  final String creatorId;
  final String creatorName;
  final String creatorImage;
  final int? totalBuy;
  final int? totalFavorite;
  final String? description;
  final List<ProductMediaImage>? listMediaImage;

  const Product(
      this.productId,
      this.productName,
      this.productImage,
      this.productPrice,
      this.creatAt,
      this.creatorId,
      this.creatorName,
      this.creatorImage,
      {this.description,
      this.listMediaImage,
      this.totalBuy,
      this.totalFavorite});

  @override
  List<Object?> get props => [
        productId,
        productImage,
        productImage,
        productName,
        creatAt,
        creatorId,
        creatorImage,
        creatorName
      ];
}
