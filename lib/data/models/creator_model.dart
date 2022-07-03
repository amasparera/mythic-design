import 'package:equatable/equatable.dart';
import '../../domain/enities/creator.dart';

class CreatorModel extends Equatable {
  final int creatorId;
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

  const CreatorModel(
      this.creatorId,
      this.nameFirst,
      this.nameLast,
      this.email,
      this.bio,
      this.image,
      this.backgroundImage,
      this.address,
      this.totalFollow,
      this.totalCollection,
      this.creatAt);

  factory CreatorModel.fromjson(Map<String, dynamic> map) {
    return CreatorModel(
        map["creatorId"],
        map["nameFirst"],
        map["nameLast"],
        map["email"],
        map["bio"],
        map["image"],
        map["backgroundImage"],
        map["address"],
        map["totalFollow"],
        map["totalCollection"],
        map["creatAt"]);
  }
  Creator toEntity() {
    return Creator(creatorId.toString(), nameFirst, nameLast, email, bio, image,
        backgroundImage, address, creatAt, totalFollow, totalCollection);
  }

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
        totalCollection,
        totalFollow
      ];
}
