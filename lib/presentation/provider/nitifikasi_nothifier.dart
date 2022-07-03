import 'package:flutter/cupertino.dart';

import '../../domain/enities/notifikasi.dart';

class NotifikasiNothifier extends ChangeNotifier {
  final List<NothifApp> _listNothif = [];
  List<NothifApp> get listNothif => _listNothif;

  addNothif(NothifApp nothifApp) {
    _listNothif.add(nothifApp);
    notifyListeners();
  }

  clearnothif(){
    _listNothif.clear();
    notifyListeners();
  }
}
