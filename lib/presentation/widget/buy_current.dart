import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/size.dart';
import '../../common/thema_app.dart';
import '../../domain/enities/product.dart';
import '../provider/wishlist_nothifier.dart';

class BuyCurrent extends StatelessWidget {
  const BuyCurrent({
    Key? key,
    required this.price,
    required this.product,
  }) : super(key: key);

  final int price;
  final Product product;

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 2,
    );

    return Container(
      margin: const EdgeInsets.only(top: coverPading),
      height: 50,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          gradient: gradientButton, borderRadius: BorderRadius.circular(50)),
      child: Container(
        height: 48,
        padding: const EdgeInsets.only(
            left: defaultPading + coverPading, top: 2, bottom: 2, right: 1.5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "current",
                  style: TextStyle(color: label),
                ),
                Text(
                  currencyFormatter.format(price),
                  style: const TextStyle(
                      color: titleActive,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            )),
            GestureDetector(onTap: (){
              context.read<WishlistNothifier>().add(context,product);
            },
              child: Consumer<WishlistNothifier>(builder: (context, data, _) {
                if (data.wishlistInt.contains(int.parse(product.productId))) {
                  return Container(
                    height: 44,
                    width: 44,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, gradient: gradientButton),
                    child: const Icon(
                      Icons.shopping_cart_checkout_rounded,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return Container(
                      height: 44,
                      width: 44,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, gradient: gradientButton),
                      child: const Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
                      ));
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
