import 'package:flutter/material.dart';

import '../../common/size.dart';
import '../../common/thema_app.dart';

class BottomApp extends StatelessWidget {
  const BottomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("asset/logo/Logo.png", height: 40),
        Image.asset("asset/logo/The New Creative Design.png", height: 25),
        Container(
          margin: const EdgeInsets.only(top: defaultPading * 4),
          width: double.infinity,
          color: titleActive,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _textBottom(text: "About"),
            _textBottom(text: "Community Guidelines"),
            _textBottom(text: "Terms of Seervice"),
            _textBottom(text: "Privacy"),
            _textBottom(text: "Careers"),
            _textBottom(text: "Help"),
            const Divider(
              color: backgroundWhite,
              thickness: 2,
              height: 50,
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: defaultPading, bottom: defaultPading),
              child: Text(
                "© 2021 Mythic, Developer by Amas Parera",
                style: TextStyle(color: backgroundWhite, fontSize: 13),
              ),
            )
          ]),
        ),
      ],
    );
  }

  Widget _textBottom({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(left: defaultPading, top: defaultPading),
      child: Text(
        text,
        style: const TextStyle(color: backgroundWhite),
      ),
    );
  }
}
