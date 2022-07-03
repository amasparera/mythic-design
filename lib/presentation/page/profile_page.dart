import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/requeststate.dart';
import '../../common/size.dart';
import '../../common/thema_app.dart';
import '../../domain/enities/user.dart';
import '../provider/nitifikasi_nothifier.dart';
import '../provider/profile_nothifier.dart';
import '../provider/wishlist_nothifier.dart';
import '../widget/bottol_app.dart';
import '../widget/loading_widget.dart';
import 'notifikasi_page.dart';
import 'wishlist_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const String routeName = "/profile";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    Future.microtask(() => context.read<ProfileNothifier>()..fecthUser());
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
          const SizedBox(
            width: defaultPading / 2,
          )
        ],
      ),
      body: Consumer<ProfileNothifier>(builder: (context, data, child) {
        if (data.nowUserState == RequestState.loading) {
          return SizedBox(width: double.infinity, child: loadingView());
        } else if (data.nowUserState == RequestState.loaded) {
          return _bodyProfile(data.user);
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
       
          LoadingWidget(
            context: context,
            borderRadius: 4,
            height: 150,
            width: MediaQuery.of(context).size.width * 8.5 / 10,
            margin: const EdgeInsets.only(top: 25),
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

  ListView _bodyProfile(User user) {
    return ListView(
      children: [
        Stack(
          children: [
            Container(
              height: 200,
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: user.backgroundImage != "" ? null : Colors.grey,
              decoration: user.backgroundImage != ""
                  ? BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://mythicserver.herokuapp.com/public/${user.backgroundImage}")))
                  : null,
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 50,
                      backgroundImage: user.image != ""
                          ? NetworkImage(
                              "https://mythicserver.herokuapp.com/public/${user.image}")
                          : null,
                      child: user.image != ""
                          ? null
                          : const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 60,
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "${user.nameFist} ${user.nameLast}",
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
                        user.id + generateRandomString(18 - user.id.length),
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
        bio(text: user.bio),
        const SizedBox(height: 12),
        myCollection(),
        const SizedBox(height: 12),
        myCoupon(),
        Center(
            child: Text(
          "Member since  ${DateFormat.y().format(DateTime.parse(user.creatAt))}",
          style: const TextStyle(color: label, fontSize: 13),
        )),
        const SizedBox(height: 12),
        Container(
          height: 50,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                  colors: [Color(0xff0038F5), Color(0xff9F03FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: MaterialButton(
            onPressed: () {
              context.read<ProfileNothifier>().logOut(context);
            },
            child: const Text(
              "Log Out",
              style: TextStyle(
                  color: offWhite, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: defaultPading * 3),
        const BottomApp(),
      ],
    );
  }

  Widget myCollection() {
    return Column(
      children: [
        const Text(
          "Your collection.",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: titleActive, fontSize: 20),
        ),
        Container(
          height: 80,
          width: double.infinity,
          color: inputBacgroud,
          margin: const EdgeInsets.symmetric(
              horizontal: defaultPading, vertical: defaultPading / 2),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: const Text(
            "Start buy your collection artwork",
            style: TextStyle(color: label),
          ),
        )
      ],
    );
  }

  Widget myCoupon() {
    return Column(
      children: [
        const Text(
          "Your coupon.",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: titleActive, fontSize: 20),
        ),
        Container(
          height: 80,
          width: double.infinity,
          color: inputBacgroud,
          margin: const EdgeInsets.symmetric(
              horizontal: defaultPading, vertical: defaultPading / 2),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: const Text(
            "Your Coupon is empty.",
            style: TextStyle(color: label),
          ),
        )
      ],
    );
  }

  Container bio({required String text}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: const Color(0xff000000).withOpacity(.05),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      margin: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Bio",
                style: TextStyle(
                  fontSize: 18,
                  color: body,
                ),
              ),
              const Spacer(),
              Image.asset(
                "asset/icons/Settings.png",
                width: 20,
              )
            ],
          ),
          const SizedBox(height: 8),
          text != ""
              ? Text(
                  text,
                  style: const TextStyle(
                    color: label,
                    height: 1.3,
                  ),
                )
              : const Text(
                  "input you bio detail",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: label,
                    fontSize: 12,
                    height: 1.3,
                  ),
                )
        ],
      ),
    );
  }
}
