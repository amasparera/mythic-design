import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../common/size.dart';
import '../../common/thema_app.dart';
import '../../domain/enities/notifikasi.dart';
import '../provider/nitifikasi_nothifier.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({Key? key}) : super(key: key);

  static const String route = "/notifikasi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingBottom(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
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
        title: const Text("Notification"),
      ),
      body: Consumer<NotifikasiNothifier>(builder: (context, data, _) {
        return ListView.builder(
            // padding: const EdgeInsets.all(defaultPading),
            itemCount: data.listNothif.length,
            itemBuilder: (context, index) => _card(data.listNothif[index]));
      }),
    );
  }

  MaterialButton _card(NothifApp data) {
    return MaterialButton(
      padding: const EdgeInsets.all(coverPading),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: coverPading),
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: Image.asset("asset/logo/Group.png"),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  data.body,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                  style: const TextStyle(color: placeholder, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  timeago.format(data.time!),
                  style: const TextStyle(color: placeholder, fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _floatingBottom(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(
          horizontal: defaultPading * 4, vertical: defaultPading * 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
              colors: [Color(0xff0038F5), Color(0xff9F03FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: MaterialButton(
        onPressed: () {
          context.read<NotifikasiNothifier>().clearnothif();
        },
        child: const Text(
          "Clear All",
          style: TextStyle(
              color: offWhite, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
