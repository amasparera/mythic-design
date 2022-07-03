import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/requeststate.dart';
import '../../common/size.dart';
import '../../common/thema_app.dart';
import '../../domain/enities/product.dart';
import '../provider/creator_nothifier.dart';
import '../provider/detail_product_nothifier.dart';
import '../widget/animasi_fade_in.dart';
import '../widget/buy_current.dart';
import '../widget/loading_widget.dart';
import 'profile_creator_page.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  const ProductDetailPage({Key? key, required this.productId})
      : super(key: key);

  static const String route = "/detail-product";

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    Future.microtask(() => context.read<ProductDetailNothifier>()
      ..fechProductDetail(widget.productId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      body: Consumer<ProductDetailNothifier>(builder: (context, data, child) {
        if (data.nowProductDetailState == RequestState.loading) {
          return SizedBox(width: double.infinity, child: loadingView());
        } else if (data.nowProductDetailState == RequestState.loaded) {
          return _body(product: data.product);
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
          LoadingWidget(
            context: context,
            borderRadius: 4,
            height: 55,
            width: MediaQuery.of(context).size.width * 3 / 4,
            margin: const EdgeInsets.only(top: defaultPading*3),
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
    );
  }

  Widget _body({required Product product}) {
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 48,
              left: defaultPading,
              right: defaultPading,
              bottom: defaultPading,
            ),
            child: Text(
              product.productName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  letterSpacing: 1,
                  color: titleActive,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Column(
              children: List.generate(
                  product.listMediaImage!.length,
                  (index) => FadeIn(
                        delay: Duration(milliseconds: 300 * index),
                        child: Image.network(
                            "https://mythicserver.herokuapp.com/public/${product.listMediaImage![index].image}",
                            fit: BoxFit.fitWidth),
                      ))),
          FutureBuilder(
              future: Future.delayed(const Duration(seconds: 1)),
              builder: (context, state) {
                if (state.connectionState == ConnectionState.done) {
                  return _delay(product: product);
                } else {
                  return const SizedBox();
                }
              })
        ],
      ),
    );
  }

  Widget _delay({required Product product}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPading),
          child: Text(
            product.description!,
            style: const TextStyle(
              color: label,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPading),
          child: Wrap(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    tag.length,
                    (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(defaultPading),
                            border: Border.all(color: placeholder)),
                        child: Text(
                          "#${tag[index]}",
                          style:
                              const TextStyle(color: placeholder, fontSize: 13),
                        ))),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              detailCover(
                  "asset/icons/favorite.png", product.totalFavorite.toString()),
              detailCover(
                  "asset/icons/terjual.png", product.totalBuy.toString()),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //       top: defaultPading * 2,
        //       left: defaultPading,
        //       right: defaultPading,
        //       bottom: defaultPading),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Expanded(
        //         child: Text(
        //           product.productName,
        //           style: const TextStyle(
        //               letterSpacing: 1,
        //               color: titleActive,
        //               fontSize: 32,
        //               fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //       const SizedBox(width: defaultPading),
        //       const Icon(Icons.favorite_border_rounded)
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPading),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProfileCreatorPage.route,
                      arguments: product.creatorId);
                },
                child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x0ff00000).withOpacity(.029),
                              blurRadius: 13.27,
                              offset: const Offset(0, 10.14))
                        ],
                        color: offWhite,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                              "https://mythicserver.herokuapp.com/public/${product.creatorImage}"),
                          radius: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPading),
                          child: Text(
                            product.creatorName,
                            style: const TextStyle(
                                color: body,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        )
                      ],
                    )),
              ),
              const Spacer(),
              Consumer<CreatorNothifier>(builder: (context, data, _) {
                return GestureDetector(
                  onTap: () {
                    data.followUnfollow(int.parse(product.creatorId));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          gradient: gradientButton,
                          borderRadius: BorderRadius.circular(50)),
                      child: data.follow.contains(int.parse(product.creatorId))
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Text(
                                "Unfollow",
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.asset("asset/icons/Follow.png",
                                  width: 32),
                            )),
                );
              })
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPading),
          child: Text(
            "Publish : ${DateFormat.yMMMMEEEEd().format(DateTime.parse(product.creatAt))}",
            style: const TextStyle(color: label, fontSize: 10),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
              horizontal: defaultPading, vertical: defaultPading * 2),
          child: BuyCurrent(price: product.productPrice, product: product),
        ),
      ],
    );
  }

  Padding detailCover(String image, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 20,
          ),
          const SizedBox(width: 4),
          Text(total),
        ],
      ),
    );
  }
}

List tag = ["black", "art", "color", "circle"];
