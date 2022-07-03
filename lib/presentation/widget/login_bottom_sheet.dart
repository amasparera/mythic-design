import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../common/size.dart';
import '../../common/thema_app.dart';
import '../page/login_page.dart';

class LoginBottomShett extends StatelessWidget {
  const LoginBottomShett({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(defaultPading),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(coverPading)),
      child: Column(
        children: [
          const Text("Sorry, you are not logged in. please login first",style: TextStyle(color: label),),
          Flexible(child: Lottie.asset("asset/lottie/106680-login-and-sign-up.json")),
          Container(
          width: double.infinity,
          height: 35,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(
              horizontal: defaultPading, vertical: defaultPading ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                  colors: [Color(0xff0038F5), Color(0xff9F03FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginPage.route);
            },
            child: const Text(
              "Login",
              style: TextStyle(
                  color: offWhite, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
            )
        ],
      ),
    );
  }
}
