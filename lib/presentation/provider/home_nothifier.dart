import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/helper_local.dart';
import '../../common/notif_local.dart';
import '../../common/requeststate.dart';
import '../../domain/enities/notifikasi.dart';
import '../../domain/enities/product.dart';
import '../../domain/user_case/get_products.dart';
import '../page/notifikasi_page.dart';
import '../page/profile_page.dart';
import '../page/search_page.dart';
import '../widget/login_bottom_sheet.dart';
import 'nitifikasi_nothifier.dart';

class HomeNotifier extends ChangeNotifier {
  final NothifLocal service ;
  final GetProducts getProducts;
  final HelperLocal helperLocal;

  HomeNotifier(this.getProducts, this.helperLocal, this.service);

  RequestState _nowProductState = RequestState.empty;
  RequestState get nowPlayingState => _nowProductState;

  RequestState _nowProductStateLoad = RequestState.empty;
  RequestState get nowPlayingStateLoad => _nowProductStateLoad;

  ScrollController homeListProduct = ScrollController();

  int get statusStateLoad {
    if (_nowProductStateLoad == RequestState.empty) {
      return 1;
    }
    return 2;
  }

  List<Product> _listProducts = [];
  List<Product> get listProducts => _listProducts;

  List<String> _listFaforite = [];
  List<String> get listFavorite => _listFaforite;

  String _message = '';
  String get message => _message;

  int page = 0;

  String? profilleImage;


  Future<void> fechProductLoad(BuildContext context) async {
    final result = await getProducts.execute(page: page);
    await Future.delayed(const Duration(seconds: 3));
    result.fold((l) {
      _nowProductStateLoad = RequestState.loaded;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l.message),
      ));
      notifyListeners();
    }, (r) {
      _nowProductStateLoad = RequestState.empty;
      _listProducts.addAll(r);
      notifyListeners();
    });
  }

  Future<void> fechProduct() async {
    _nowProductState = RequestState.loading;
    notifyListeners();
    final result = await getProducts.execute(page: page);
    result.fold((l) {
      _nowProductState = RequestState.error;
      _message = l.message;
      notifyListeners();
    }, (r) {
      _nowProductState = RequestState.loaded;
      _listProducts = r;
      notifyListeners();
    });
  }

  Future<void> getlogin() async {
    profilleImage = null;
    page = 0;
    var isLogin = await helperLocal.loadLogin();
    if (isLogin) {
      profilleImage = await helperLocal.loadProfileImage();
      notifyListeners();
    }
  }

  Future<void> getListFavorite() async {
    _listFaforite = await helperLocal.loadFavorite() ?? [];
  }

  void goToProfile(context) async {
    bool login = await helperLocal.loadLogin();
    if (login) {
      Navigator.pushNamed(context, ProfilePage.routeName);
    } else {
      showModalBottomSheet(
          context: context,
          builder: (context) => BottomSheet(
              backgroundColor: Colors.white,
              onClosing: () {},
              builder: (context) => const LoginBottomShett()));
    }
  }

  void goToSeach(context) {
    Navigator.pushNamed(context, SearchPage.route);
  }

  void shownothif(BuildContext context) async {
    helperLocal.loadInstal().then((value) {
      if (value == false) {
        Future.delayed(const Duration(seconds: 5), () {
          context
              .read<NotifikasiNothifier>()
              .addNothif(_install..time = DateTime.now());
          helperLocal.saveInstal(instal: true);
          service.showNotif(
              id: _install.id,
              body: _install.body,
              title: _install.title,
              payload: NotifikasiPage.route);
          notifyListeners();
        });
      }
    });
  }

  void init(context) {
    _nowProductStateLoad = RequestState.empty;
    service.init();
    service.onNothif.listen((value) {
      if (value != null) {
        final data = value;
        service.onNothif.value = null;
        Navigator.pushNamed(context, data);
      }
    });

    homeListProduct.addListener(() async {
      if (homeListProduct.position.maxScrollExtent == homeListProduct.offset) {
        _nowProductStateLoad = RequestState.loading;
        notifyListeners();
        page = page + 1;
        await fechProductLoad(context);
      }
    });
  }

  final NothifApp _install = NothifApp(
    title: "Developer : Amas Parera",
    body:
        "Terimakasih telah menguji coba aplikasi saya, mohon maaf sebagain fitur masih di kerjakan di bagian server.\nSegala masukan bisa dikirimkan ke developer terimakasih.",
    id: 0,
  );

  @override
  void dispose() {
    homeListProduct.dispose();
    super.dispose();
  }
}
