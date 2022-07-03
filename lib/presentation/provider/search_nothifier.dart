
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/api_url.dart';
import '../../common/requeststate.dart';
import '../../common/tipe_search.dart';
import '../../domain/enities/product_media_image.dart';
import '../../domain/user_case/search_product.dart';

class SearchNothifier extends ChangeNotifier {
  final SearchProductUseCase searchProductUseCase;
  final ApiUrl api;

  SearchNothifier(this.searchProductUseCase, this.api);

  RequestState _nowStateTabbar = RequestState.empty;
  RequestState get nowStateTabbar => _nowStateTabbar;

  RequestState _serachState = RequestState.empty;
  RequestState get serachState => _serachState;

  List<ProductMediaImage> _listProduct = [];
  List<ProductMediaImage> get listProduct => _listProduct;

  String _message = "";
  String get message => _message;

  bool _mode = false;
  bool get mode => _mode;

  TextEditingController textEditingController = TextEditingController();

  int _positions = 0;

  void init() {
    _nowStateTabbar = RequestState.loading;
    _message = "";
    _mode = false;
    seacrh(TypeSearch.populer);
  }

  void onTap(int value) {
    _nowStateTabbar = RequestState.loading;
    if (value != 100) {
      _positions = value;
    }

    notifyListeners();
    switch (value) {
      case 0:
        seacrh(TypeSearch.populer);
        break;
      case 1:
        seacrh(TypeSearch.productNew);
        break;
      case 2:
        seacrh(TypeSearch.highPrice);
        break;
      case 3:
        seacrh(TypeSearch.lowPrice);
        break;
      case 4:
        seacrh(TypeSearch.cosplay);
        break;
      case 5:
        seacrh(TypeSearch.illustration);
        break;
      default:
        _mode = true;
        _serachState = RequestState.loading;
        notifyListeners();
        seacrh(TypeSearch.search, text: textEditingController.text);
    }
  }

  Future seacrh(TypeSearch typeSearch, {String? text}) async {
    final result =
        await searchProductUseCase.execute(typeSearch: typeSearch, text: text);
    result.fold((l) {
      _message = l.message;
      _nowStateTabbar = RequestState.error;
      if (_mode == true) {
        _serachState = RequestState.error;
      }
      notifyListeners();
    }, (r) {
      _listProduct = r;
      _nowStateTabbar = RequestState.loaded;
      if (_mode == true) {
        _serachState = RequestState.loaded;
      }
      notifyListeners();
    });
  }

  void back() {
    _mode = false;
    notifyListeners();
    onTap(_positions);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
