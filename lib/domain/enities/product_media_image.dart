import 'package:equatable/equatable.dart';

class ProductMediaImage extends Equatable {
  final String id;
  final String creatorId;
  final String productId;
  final String image;

  const ProductMediaImage(
      {required this.id,
      required this.creatorId,
      required this.productId,
      required this.image});

  @override
  List<Object?> get props => [id, creatorId, productId, image];
}
