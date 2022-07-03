import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/requeststate.dart';
import '../../common/size.dart';
import '../../common/thema_app.dart';
import '../provider/search_nothifier.dart';
import '../widget/animasi_fade_in.dart';
import 'product_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  static const String route = "/search";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    context.read<SearchNothifier>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> category = [
      "Populer",
      "New",
      "High Price",
      "Low Price",
      "Cosplay",
      "Illutration"
    ];
    return DefaultTabController(
      length: category.length,
      child:
          Scaffold(body: Consumer<SearchNothifier>(builder: (context, data, _) {
        return SafeArea(
            child: Column(children: [
          Container(
            height: 48,
            margin: const EdgeInsets.only(
                top: coverPading * 2,
                bottom: coverPading * 1.5,
                left: defaultPading,
                right: defaultPading),
            // width: MediaQuery.of(context).size.width * .88,
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPading, vertical: defaultPading / 2.5),
            decoration: BoxDecoration(
                color: inputBacgroud,
                borderRadius: BorderRadius.circular(defaultPading)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("asset/icons/Icon.png", width: 25),
                const SizedBox(width: coverPading),
                Expanded(
                  child: TextField(
                      onSubmitted: (value) => data.onTap(100),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search items, collections, and accounts",
                        hintStyle: TextStyle(
                            color: placeholder, fontSize: 14, height: 1.2),
                      )),
                )
              ],
            ),
          ),
          if (data.mode == false) _tabbar(context, category),
          if (data.mode == false) _tabbarview(category),
          if (data.mode == true) Expanded(child: _viewSearchResult(data)),
        ]));
      })),
    );
  }

  Expanded _tabbarview(List<String> category) {
    return Expanded(
        child: TabBarView(
            children: List.generate(
      category.length,
      (index) => Consumer<SearchNothifier>(builder: (context, data, _) {
        switch (data.nowStateTabbar) {
          case RequestState.loading:
            return Shimmer.fromColors(
              period: const Duration(seconds: 4),
              baseColor: Colors.grey.withOpacity(.1),
              highlightColor: const Color.fromARGB(130, 255, 255, 255),
              child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: defaultPading),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      crossAxisCount: 2),
                  itemCount: 6,
                  itemBuilder: (context, index) =>
                      Container(color: Colors.grey)),
            );

          case RequestState.loaded:
            return GridView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 4, vertical: defaultPading),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 4, mainAxisSpacing: 4, crossAxisCount: 2),
                itemCount: data.listProduct.length,
                itemBuilder: (context, index) => FadeIn(
                      delay: Duration(milliseconds: 150 * index),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, ProductDetailPage.route,
                            arguments: data.listProduct[index].productId),
                        child: Container(
                          color: Colors.grey.withOpacity(.1),
                          child: Image.network(
                            data.api.baseUrlImage +
                                data.listProduct[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ));

          default:
            return Center(child: Text(data.message));
        }
      }),
    )));
  }

  Container _tabbar(BuildContext context, List<String> category) {
    return Container(
        alignment: Alignment.centerLeft,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: defaultPading),
        padding: const EdgeInsets.symmetric(vertical: defaultPading / 2),
        child: TabBar(
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
            onTap: (value) {
              context.read<SearchNothifier>().onTap(value);
            },
            indicator: BoxDecoration(
                // color: Colors.black,
                gradient: gradientButton,
                borderRadius: BorderRadius.circular(20)),
            isScrollable: true,
            splashBorderRadius: BorderRadius.circular(20),
            unselectedLabelStyle:
                const TextStyle(color: label, fontWeight: FontWeight.bold),
            unselectedLabelColor: label,
            tabs: List.generate(
                category.length,
                (index) => Tab(
                      text: category[index],
                    ))));
  }

  Widget _viewSearchResult(SearchNothifier data) {
    switch (data.serachState) {
      case RequestState.loading:
        return Shimmer.fromColors(
          period: const Duration(seconds: 4),
          baseColor: Colors.grey.withOpacity(.1),
          highlightColor: const Color.fromARGB(130, 255, 255, 255),
          child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: 4, vertical: defaultPading),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 4, mainAxisSpacing: 4, crossAxisCount: 2),
              itemCount: 6,
              itemBuilder: (context, index) => Container(color: Colors.grey)),
        );

      case RequestState.loaded:
        return GridView.builder(
            padding: const EdgeInsets.symmetric(
                horizontal: 4, vertical: defaultPading),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 4, mainAxisSpacing: 4, crossAxisCount: 2),
            itemCount: data.listProduct.length,
            itemBuilder: (context, index) => FadeIn(
                  delay: Duration(milliseconds: 150 * index),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, ProductDetailPage.route,
                        arguments: data.listProduct[index].productId),
                    child: Container(
                      color: Colors.grey.withOpacity(.1),
                      child: Image.network(
                        data.api.baseUrlImage + data.listProduct[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ));

      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.search_rounded, color: placeholder, size: 18),
                Text(
                  data.message,
                  style: const TextStyle(color: placeholder),
                ),
              ],
            ),
            TextButton(onPressed: () => data.back(), child: const Text("Back"))
          ],
        );
    }
  }
}
