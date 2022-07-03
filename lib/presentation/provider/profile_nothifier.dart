import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../common/helper_local.dart';
import '../../common/requeststate.dart';
import '../../domain/enities/user.dart';
import '../../domain/user_case/get_user.dart';
import '../page/home_page.dart';

class ProfileNothifier extends ChangeNotifier {
  final GetUser getUser;
  final HelperLocal helperLocal;
  ProfileNothifier(
    this.helperLocal,
    this.getUser,
  );

  RequestState _nowUserState = RequestState.empty;
  RequestState get nowUserState => _nowUserState;

  late User _user;
  User get user => _user;

  String _message = '';
  String get message => _message;

  Future<void> fecthUser() async {
    _nowUserState = RequestState.loading;
    notifyListeners();
    var id = await helperLocal.loadProfileId();

    final result = await getUser.execute(id: id.toString());
    result.fold((l) {
      _message = l.message;
      _nowUserState = RequestState.error;
      notifyListeners();
    }, (r) {
      _user = r;
      _nowUserState = RequestState.loaded;
      notifyListeners();
    });
  }

  logOut(BuildContext context) {
    helperLocal.resetData();
    Navigator.pushNamedAndRemoveUntil(
        context, HomePage.route, ModalRoute.withName('/'));
  }
}
