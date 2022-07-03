import 'package:flutter/material.dart';

import '../../common/thema_app.dart';

class WrapSocialMedia extends StatelessWidget {
  const WrapSocialMedia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 6, children: [
      _chisSosialMedia("asset/icon-social-media/Instragram.png","Instagram"),
      _chisSosialMedia("asset/icon-social-media/Behance.png","Bihence"),
      _chisSosialMedia("asset/icon-social-media/Facebook.png","Facebook"),
      _chisSosialMedia("asset/icon-social-media/Gmail.png","Gmail"),
      _chisSosialMedia("asset/icon-social-media/Line.png","Line"),
      _chisSosialMedia("asset/icon-social-media/Tiktok.png","Tiktok"),
      _chisSosialMedia("asset/icon-social-media/BBM.png","Bbm"),
      _chisSosialMedia("asset/icon-social-media/Whatsapp.png","Whatsapp"),
      _chisSosialMedia("asset/icon-social-media/Instragram.png","Instagram"),
    ]);
  }

  Chip _chisSosialMedia(String asset,String name) {
    return Chip(shadowColor: Colors.black.withOpacity(.1),
        backgroundColor: offWhite,
        elevation: 5,
        avatar: Image.asset(
          asset,
          width: 20,
        ),
        label: Text(name));
  }
}
