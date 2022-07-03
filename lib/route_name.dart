import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './presentation/page/home_page.dart';
import './presentation/page/login_page.dart';
import './presentation/page/notifikasi_page.dart';
import './presentation/page/pay.dart';
import './presentation/page/profile_creator_page.dart';
import './presentation/page/profile_page.dart';
import './presentation/page/search_page.dart';
import './presentation/page/wishlist_page.dart';

import 'presentation/page/product_detail_page.dart';

Route<dynamic>? navigasi(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return null;
    case HomePage.route:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case ProfilePage.routeName:
      return MaterialPageRoute(builder: (_) => const ProfilePage());
    case ProductDetailPage.route:
      return MaterialPageRoute(
          builder: (_) => ProductDetailPage(
                productId: settings.arguments as String,
              ));
    case LoginPage.route:
      return MaterialPageRoute(builder: (_) => LoginPage());
    case ProfileCreatorPage.route:
      return MaterialPageRoute(
          builder: (_) =>
              ProfileCreatorPage(creatorId: settings.arguments as String));
    case SearchPage.route:
      return MaterialPageRoute(builder: (_) => const SearchPage());

    case NotifikasiPage.route:
      return CupertinoPageRoute(builder: (_) => const NotifikasiPage());
    case WishlistPage.route:
      return CupertinoPageRoute(builder: (_) => const WishlistPage());
    case PayPage.route:
      return CupertinoPageRoute(
          builder: (_) => PayPage(
                price: settings.arguments as int,
              ));
    default:
      return MaterialPageRoute(builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text('Page not found :('),
          ),
        );
      });
  }
}
