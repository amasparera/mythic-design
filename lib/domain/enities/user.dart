import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String nameFist;
  final String nameLast;
  final String email;
  final String bio;
  final String creatAt;
  final String image;
  final String backgroundImage;

  const User(
      {required this.image,
      required this.backgroundImage,
      required this.id,
      required this.nameFist,
      required this.nameLast,
      required this.email,
      required this.bio,
      required this.creatAt});

  @override
  List<Object?> get props => [id, nameFist, nameLast, email, bio, creatAt];
}
