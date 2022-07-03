import 'package:equatable/equatable.dart';

class Wishlist extends Equatable {
  final String id;
  final String idUser;
  final String idProduct;
  final String image;
  final String title;
  final String price;
  final String creatAt;

  const Wishlist(this.id, this.idUser, this.idProduct, this.image, this.title,
      this.creatAt, this.price);

  factory Wishlist.fromjson(Map<String, dynamic> map) {
    return Wishlist(
      map["id"],
      map["idUser"],
      map["idProduct"],
      map["image"],
      map["title"],
      map["price"],
      map["creatAt"],
    );
  }

  @override
  List<Object?> get props => [id, idProduct, idUser, image, title, creatAt];
}
