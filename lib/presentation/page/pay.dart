import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/size.dart';
import '../../common/thema_app.dart';

class PayPage extends StatelessWidget {
  final int price;
  const PayPage({
    Key? key,
    required this.price,
  }) : super(key: key);

  static const String route = "/pay";

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "asset/icons/Arrow_back.png",
            height: 18,
          ),
        ),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(defaultPading),
          alignment: Alignment.centerLeft,
          height: 50,
          decoration: BoxDecoration(color: offWhite, boxShadow: [
            BoxShadow(
                blurRadius: 4,
                color: Colors.black.withOpacity(.05),
                offset: const Offset(0, 4))
          ]),
          child: Text(
            currencyFormatter.format(price),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: titleActive,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(coverPading * 2.5),
          child: Text(
            "Select Payment Method",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: titleActive,
            ),
          ),
        ),
        _card("asset/icons/Group 264.png", "Credit Card"),
        _card("asset/icons/PayPal.png", "Paypal"),
        _coupond(),
        Container(
          height: 50,
          width: double.infinity,
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Sorry server error or maintener...."),
              ));
            },
            child: const Text(
              "Procesing",
              style: TextStyle(
                  color: offWhite, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ]),
    );
  }
  // bool credit = false;

  Widget _card(String imageAssets, String name) {
    bool paypal = false;
    return StatefulBuilder(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          state(() => paypal = !paypal);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: defaultPading, vertical: defaultPading / 2),
          padding: const EdgeInsets.all(coverPading * 1.5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    offset: const Offset(0, 4),
                    blurRadius: 4)
              ]),
          child: Row(children: [
            Image.asset(
              imageAssets,
              width: 25,
            ),
            const SizedBox(width: defaultPading),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleActive,
              ),
            ),
            const Spacer(),
            paypal == false
                ? const SizedBox()
                : const Icon(Icons.check, color: Colors.green),
          ]),
        ),
      );
    });
  }

  Widget _coupond() {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: defaultPading, vertical: defaultPading / 2),
      padding: const EdgeInsets.all(coverPading * 1.5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.05),
                offset: const Offset(0, 4),
                blurRadius: 4)
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("asset/icons/coupons 1.png", width: 20),
              const SizedBox(width: coverPading),
              const Text(
                "Coupon",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Enter your coupon...",
                  hintStyle: TextStyle(fontSize: 12),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xffF0F0F0)),
            ),
          )
        ],
      ),
    );
  }
}
