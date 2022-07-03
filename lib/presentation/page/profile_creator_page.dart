import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mythicdesign/presentation/page/product_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/requeststate.dart';
import '../../common/size.dart';
import '../../common/thema_app.dart';
import '../../domain/enities/creator.dart';
import '../provider/creator_nothifier.dart';
import '../provider/home_nothifier.dart';
import '../provider/nitifikasi_nothifier.dart';
import '../provider/wishlist_nothifier.dart';
import '../widget/bottol_app.dart';
import '../widget/loading_widget.dart';
import '../widget/wrap_sosial_media.dart';
import 'notifikasi_page.dart';
import 'wishlist_page.dart';

class ProfileCreatorPage extends StatefulWidget {
  final String creatorId;
  const ProfileCreatorPage({Key? key, required this.creatorId})
      : super(key: key);

  static const String route = "/profile-creator";

  @override
  State<ProfileCreatorPage> createState() => _ProfileCreatorPageState();
}

class _ProfileCreatorPageState extends State<ProfileCreatorPage> {
  @override
  void initState() {
    Future.microtask(() => context.read<CreatorNothifier>()
      ..init()
      ..fechdata(widget.creatorId)
      ..fechdataImage(widget.creatorId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: defaultPading * 2 / 3,
        automaticallyImplyLeading: false,
        title: Image.asset(
          "asset/logo/Logo.png",
          width: 150,
        ),
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.pushNamed(context, NotifikasiPage.route);
              },
              icon: Stack(
                children: [
                  Image.asset(
                    "asset/icons/Notification.png",
                    width: 24,
                  ),
                  Positioned(
                      right: 0,
                      child: Consumer<NotifikasiNothifier>(
                          builder: (context, data, _) {
                        if (data.listNothif.isNotEmpty) {
                          return const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5,
                          );
                        }
                        return const SizedBox();
                      }))
                ],
              )),
          IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.pushNamed(context, WishlistPage.route);
              },
              icon: Stack(
                children: [
                  Image.asset(
                    "asset/icons/Cart.png",
                    width: 24,
                  ),
                  Positioned(
                      right: 0,
                      child: Consumer<WishlistNothifier>(
                          builder: (context, data, _) {
                        if (data.wishlistInt.isNotEmpty) {
                          return const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5,
                          );
                        }
                        return const SizedBox();
                      }))
                ],
              )),
          IconButton(
              splashRadius: 20,
              onPressed: () {
                context.read<HomeNotifier>().goToProfile(context);
              },
              icon: Consumer<HomeNotifier>(builder: (context, data, _) {
                return CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: data.profilleImage != null ||
                          data.profilleImage == ""
                      ? NetworkImage(
                          "https://mythicserver.herokuapp.com/public/${data.profilleImage!}")
                      : null,
                  radius: 15,
                  child: data.profilleImage == null || data.profilleImage == ""
                      ? const Icon(
                          Icons.person,
                          color: Colors.white,
                        )
                      : null,
                );
              })),
          const SizedBox(
            width: defaultPading / 4,
          )
        ],
      ),
      body: Consumer<CreatorNothifier>(builder: (context, data, _) {
        if (data.nowCreaotrState == RequestState.loading) {
          return SizedBox(
            width: double.infinity,
            child: loadingView(),
          );
        } else if (data.nowCreaotrState == RequestState.loaded) {
          return _body(context, data.creator);
        } else {
          return Center(
            child: Text(data.message),
          );
        }
      }),
    );
  }

  Widget loadingView() {
    return Shimmer.fromColors(
      // loop: 2,
      period: const Duration(seconds: 4),
      baseColor: Colors.grey.withOpacity(.1),
      highlightColor: const Color.fromARGB(130, 255, 255, 255),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 45,
          ),
          LoadingWidget(
            context: context,
            borderRadius: 4,
            height: 30,
            width: MediaQuery.of(context).size.width * 2 / 4,
            margin: const EdgeInsets.only(top: 10),
          ),
          LoadingWidget(
            context: context,
            borderRadius: 4,
            height: 18,
            width: MediaQuery.of(context).size.width * 2 / 4,
            margin: const EdgeInsets.only(top: 4),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                3,
                (index) => LoadingWidget(
                  context: context,
                  borderRadius: 4,
                  height: 45,
                  width: 80,
                  margin: const EdgeInsets.only(top: 25),
                ),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: LoadingWidget(
              context: context,
              borderRadius: 4,
              height: 18,
              width: MediaQuery.of(context).size.width * 1 / 4,
              margin: const EdgeInsets.only(top: 20, left: defaultPading),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: LoadingWidget(
              context: context,
              borderRadius: 4,
              height: 18,
              width: MediaQuery.of(context).size.width * 3.4 / 4,
              margin: const EdgeInsets.only(top: 20, left: defaultPading),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: LoadingWidget(
              context: context,
              borderRadius: 4,
              height: 18,
              width: MediaQuery.of(context).size.width * 3.4 / 4,
              margin: const EdgeInsets.only(top: 8, left: defaultPading),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: LoadingWidget(
              context: context,
              borderRadius: 4,
              height: 18,
              width: MediaQuery.of(context).size.width * 3.4 / 4,
              margin: const EdgeInsets.only(top: 8, left: defaultPading),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: LoadingWidget(
              context: context,
              borderRadius: 4,
              height: 18,
              width: MediaQuery.of(context).size.width * 3 / 4,
              margin: const EdgeInsets.only(top: 8, left: defaultPading),
            ),
          ),
        ],
      ),
    );
  }

  String generateRandomString(int len) {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  ListView _body(BuildContext context, Creator creator) {
    return ListView(children: [
      Stack(
        children: [
          Container(
            height: 250,
          ),
          Container(
            height: 125,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://mythicserver.herokuapp.com/public/${creator.backgroundImage}"))),
          ),
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 73),
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://mythicserver.herokuapp.com/public/${creator.image}"),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "${creator.nameFirst} ${creator.nameLast}",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: titleActive),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      creator.creatorId +
                          generateRandomString(18 - creator.creatorId.length),
                      style: const TextStyle(fontSize: 13, color: label),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.copy_rounded,
                      size: 16,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPading * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.read<CreatorNothifier>().image.length.toString(),
                  style: const TextStyle(
                      color: body, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Collected",
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold, color: label),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creator.totalFollow.toString(),
                  style: const TextStyle(
                      color: body, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Followes",
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold, color: label),
                )
              ],
            ),
            Consumer<CreatorNothifier>(builder: (context, data, _) {
              return GestureDetector(
                onTap: () {
                  data.followUnfollow(int.parse(creator.creatorId));
                },
                child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        gradient: gradientButton,
                        borderRadius: BorderRadius.circular(6)),
                    child: data.follow.contains(int.parse(creator.creatorId))
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPading * 1.2,
                                vertical: coverPading),
                            child: const Text("Unfollow",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPading * 1.2,
                                vertical: coverPading),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.5)),
                            child: Image.asset("asset/icons/Follow.png",
                                width: 48),
                          )),
              );
            })
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(
            top: defaultPading * 2, left: defaultPading, bottom: defaultPading),
        child: Text(
          "Bio Creator",
          style: TextStyle(color: label, fontSize: 18),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPading),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset("asset/icons/google-maps 1.png", width: 16),
            const SizedBox(width: 4),
            Text(creator.address)
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
            top: defaultPading, left: defaultPading, right: defaultPading),
        child: Text(
          creator.bio,
          style: const TextStyle(fontSize: 13, height: 1.4, color: body),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(defaultPading),
        child: Text(
          "Member since  ${DateFormat.y().format(DateTime.parse(creator.creatAt))}",
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: label),
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPading),
        child: WrapSocialMedia(),
      ),
      const Padding(
        padding: EdgeInsets.all(defaultPading),
        child: Text(
          "Collection",
          style: TextStyle(
              fontSize: 18, color: label, fontWeight: FontWeight.bold),
        ),
      ),
      Consumer<CreatorNothifier>(builder: (context, data, _) {
        if (data.nowCreaotrStateImage == RequestState.loading) {
          return Wrap(
              children: List.generate(4, (index) {
            return GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                ));
          }));
        } else if (data.nowCreaotrStateImage == RequestState.loaded) {
          return Wrap(
            children: List.generate(data.image.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailPage.route,
                      arguments: data.image[index].productId);
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  child: Image.network(
                    "https://mythicserver.herokuapp.com/public/${data.image[index].image}",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          );
        } else {
          return Center(child: Text(data.message));
        }
      }),
      const SizedBox(height: defaultPading * 4),
      const BottomApp(),
    ]);
  }
}
