import 'package:equatable/equatable.dart';

import '../../domain/enities/user.dart';

class UserModel extends Equatable {
  final int id;
  final String nameFist;
  final String nameLast;
  final String email;
  final String bio;
  final String creatAt;
  final String image;
  final String backgroundImage;

  const UserModel(
      {required this.image,
      required this.backgroundImage,
      required this.id,
      required this.nameFist,
      required this.nameLast,
      required this.email,
      required this.bio,
      required this.creatAt});

  factory UserModel.fromjson(Map<String, dynamic> map) {
    
    return UserModel(
        image: map["image"] ,
        backgroundImage: map["backgroundImage"],
        id: map["id"],
        nameFist: map["name"],
        nameLast: map["nameLast"] ?? "",
        email: map["email"],
        bio: map["bio"],
        creatAt: map["creatAt"]);
  }

  User toEntity() {
    return User(
        backgroundImage: backgroundImage,
        bio: bio,
        creatAt: creatAt,
        email: email,
        id: id.toString(),
        image: image,
        nameFist: nameFist,
        nameLast: nameLast);
  }

  @override
  List<Object?> get props => [id, nameFist, nameLast, email, bio, creatAt];
}
