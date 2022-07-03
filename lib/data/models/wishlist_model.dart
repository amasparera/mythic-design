import 'package:equatable/equatable.dart';

import '../../domain/enities/wishlist.dart';

class WishlistModel extends Equatable {
  final int id;
  final int idUser;
  final int idProduct;
  final String price;
  final String image;
  final String title;
  final String creatAt;

  const WishlistModel(this.id, this.idUser, this.idProduct, this.image,
      this.title, this.creatAt, this.price);

  factory WishlistModel.fromjson(Map<String, dynamic> map) {
    return WishlistModel(map["id"], map["idUser"], map["idProduct"],
        map["image"], map["title"], map["title"], map["price"]);
  }

  Wishlist toEnities() {
    return Wishlist(id.toString(), idUser.toString(), idProduct.toString(),
        image, title, creatAt, price);
  }

  @override
  List<Object?> get props => [id, idProduct, idUser, image, title, creatAt];
}
