import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/requeststate.dart';
import '../../common/size.dart';
import '../../common/thema_app.dart';
import '../provider/home_nothifier.dart';
import '../provider/nitifikasi_nothifier.dart';
import '../provider/wishlist_nothifier.dart';
import '../widget/card_home.dart';
import '../widget/loading_widget.dart';
import 'notifikasi_page.dart';
import 'product_detail_page.dart';
import 'wishlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<HomeNotifier>()
        ..init(context)
        ..getlogin()
        ..getListFavorite()
        ..fechProduct()
        ..shownothif(context);
      context.read<WishlistNothifier>().getWishlist();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   context.read<HomeNotifier>().fechProductLoad();
        // }),
        appBar: AppBar(
          elevation: 0,
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
                    child:
                        data.profilleImage == null || data.profilleImage == ""
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
        body: Consumer<HomeNotifier>(builder: (context, data, child) {
          if (data.nowPlayingState == RequestState.loading) {
            return loadingView();
          } else if (data.nowPlayingState == RequestState.loaded) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: data.homeListProduct,
              padding: EdgeInsets.zero,
              itemCount: data.listProducts.length + data.statusStateLoad,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return coverHomeSearch(context);
                }

                if (data.nowPlayingStateLoad == RequestState.loaded &&
                    index == data.listProducts.length + 1) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(defaultPading),
                    child: Text(
                      data.message,
                    ),
                  ));
                }
                if (data.nowPlayingStateLoad != RequestState.empty &&
                    index == data.listProducts.length + 1) {
                  return _loadProducts();
                }
                return CardHome(
                  onTap: () => Navigator.pushNamed(
                      context, ProductDetailPage.route,
                      arguments: data.listProducts[index - 1].productId),
                  product: data.listProducts[index - 1],
                  statusFavorite: data.listFavorite
                      .contains(data.listProducts[index - 1].productId),
                );
              },
            );
          } else {
            return Center(child: Text(data.message));
          }
        }));
  }

  SizedBox _loadProducts() {
    return SizedBox(
        height: 60,
        width: double.infinity,
        child: Center(
          child: Shimmer.fromColors(
            period: const Duration(seconds: 4),
            baseColor: Colors.grey.withOpacity(.7),
            highlightColor: const Color.fromARGB(130, 255, 255, 255),
            child: const Text(
              "Loading...",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  Container coverHomeSearch(BuildContext context) => Container(
        color: offWhite,
        child: Column(
          children: [
            const SizedBox(height: coverPading * 2),
            const Text(
              "Discover, Collect, And Seller",
              style: TextStyle(
                  color: label, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: coverPading),
            const Text(
              "Digital Design",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: titleActive),
            ),
            GestureDetector(
              onTap: () {
                context.read<HomeNotifier>().goToSeach(context);
                // showSearch(context: context, delegate: CustomSearch());
              },
              child: Container(
                alignment: Alignment.center,
                height: 48,
                margin: const EdgeInsets.only(
                    top: coverPading * 2,
                    bottom: coverPading * 1.5,
                    left: defaultPading * 1.5,
                    right: defaultPading * 1.5),
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPading / 2.2,
                    vertical: defaultPading / 2.5),
                decoration: BoxDecoration(
                    color: inputBacgroud,
                    borderRadius: BorderRadius.circular(defaultPading)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("asset/icons/Icon.png", width: 25),
                    const SizedBox(width: coverPading),
                    const Text(
                      "Search items, collections, and accounts",
                      style: TextStyle(color: placeholder, fontSize: 13),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget loadingView() {
    return SizedBox(
      width: double.infinity,
      child: Shimmer.fromColors(
        loop: 2,
        period: const Duration(seconds: 4),
        baseColor: Colors.grey.withOpacity(.1),
        highlightColor: const Color.fromARGB(130, 255, 255, 255),
        child: Column(
          children: [
            LoadingWidget(
              context: context,
              borderRadius: 4,
              height: 25,
              width: MediaQuery.of(context).size.width * 2 / 3,
              margin: const EdgeInsets.only(top: 20),
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
              height: 40,
              width: MediaQuery.of(context).size.width * 3 / 4,
              margin: const EdgeInsets.only(top: 18),
            ),
            LoadingWidget(
              context: context,
              borderRadius: 4,
              height: 400,
              width: MediaQuery.of(context).size.width * 8.5 / 10,
              margin: const EdgeInsets.only(top: 25),
            ),
          ],
        ),
      ),
    );
  }
}
