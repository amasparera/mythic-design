import 'package:equatable/equatable.dart';

class Creator extends Equatable {
  final String creatorId;
  final String nameFirst;
  final String nameLast;
  final String email;
  final String bio;
  final String image;
  final String backgroundImage;
  final String address;
  final String creatAt;
  final int totalFollow;
  final int totalCollection;

  const Creator(
      this.creatorId,
      this.nameFirst,
      this.nameLast,
      this.email,
      this.bio,
      this.image,
      this.backgroundImage,
      this.address,
      this.creatAt,
      this.totalFollow,
      this.totalCollection);

  @override
  List<Object?> get props => [
        creatorId,
        nameFirst,
        nameLast,
        email,
        bio,
        image,
        backgroundImage,
        address,
        creatAt,
        totalCollection,
        totalFollow
      ];
}
