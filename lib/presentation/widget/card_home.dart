import 'package:flutter/material.dart';

import '../../common/size.dart';
import '../../common/thema_app.dart';
import '../../domain/enities/product.dart';
import '../page/profile_creator_page.dart';
import 'buy_current.dart';

class CardHome extends StatelessWidget {
  const CardHome(
      {Key? key,
      this.onTap,
      required this.product,
      required this.statusFavorite})
      : super(key: key);

  final GestureTapCallback? onTap;
  final Product product;
  final bool statusFavorite;

  @override
  Widget build(BuildContext context) {
    bool isVaforite = statusFavorite;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
            left: defaultPading, right: defaultPading, bottom: defaultPading),
        padding: const EdgeInsets.all(coverPading),
        width: double.infinity,
        decoration: BoxDecoration(
            color: whiteCard,
            borderRadius: BorderRadius.circular(coverPading * 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              margin: const EdgeInsets.only(bottom: coverPading * 1.5),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(coverPading * 1.5),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://mythicserver.herokuapp.com/public/${product.productImage}"))),
            ),
            Text(product.productName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: coverPading),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProfileCreatorPage.route,
                        arguments: product.creatorId);
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage("https://mythicserver.herokuapp.com/public/${product.creatorImage}"),
                  ),
                ),
                const SizedBox(width: coverPading / 2),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ProfileCreatorPage.route,
                            arguments: product.creatorId);
                      },
                      child: Text(
                        product.creatorName,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: body),
                      ),
                    ),
                    const Text(
                      "creator",
                      style: TextStyle(color: label, fontSize: 14),
                    )
                  ],
                )),
                StatefulBuilder(
                  builder: (context, setState) => GestureDetector(
                      onTap: () => setState(() => isVaforite = !isVaforite),
                      child: Icon(
                        Icons.favorite,
                        color: isVaforite ? Colors.red : Colors.grey,
                      )),
                ),
                const SizedBox(
                  width: coverPading,
                )
              ],
            ),
            BuyCurrent(
              price: product.productPrice,
              product: product,
            )
          ],
        ),
      ),
    );
  }
}
