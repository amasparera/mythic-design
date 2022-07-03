import 'package:flutter/material.dart';
import './common/thema_app.dart';
import './presentation/page/home_page.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di;

import 'presentation/provider/creator_nothifier.dart';
import 'presentation/provider/detail_product_nothifier.dart';
import 'presentation/provider/home_nothifier.dart';
import 'presentation/provider/login_nothifier.dart';
import 'presentation/provider/nitifikasi_nothifier.dart';
import 'presentation/provider/profile_nothifier.dart';
import 'presentation/provider/search_nothifier.dart';
import 'presentation/provider/wishlist_nothifier.dart';
import 'route_name.dart';

void main(List<String> args) async {
  
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // HelperLocal().saveLogin(login: false);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.locator<HomeNotifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<ProfileNothifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<LoginNothifier>()),
        ChangeNotifierProvider(
            create: (_) => di.locator<ProductDetailNothifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<CreatorNothifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<WishlistNothifier>()),
        ChangeNotifierProvider(
            create: (_) => di.locator<NotifikasiNothifier>()),
        ChangeNotifierProvider(create: (_) => di.locator<SearchNothifier>()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: thmeaSiang(),
          // navigatorObservers: [routeObserver],
          initialRoute: HomePage.route,
          onGenerateRoute: navigasi),
    );
  }
}
