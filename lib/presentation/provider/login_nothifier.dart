import 'package:flutter/material.dart';

import '../../common/helper_local.dart';
import '../../domain/user_case/login_auth.dart';
import '../../domain/user_case/singup_auth.dart';
import '../page/home_page.dart';

class LoginNothifier extends ChangeNotifier {
  final LoginAuth loginAuth;
  final SingUpAuth singUpAuth;
  final HelperLocal helperLocal;

  LoginNothifier(this.loginAuth, this.singUpAuth, this.helperLocal);

  bool _isLogin = true;
  bool get isLogin => _isLogin;

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  bool _valid = false;
  bool get valid => _valid;

  String _message = "";
  String get message => _message;

  void swipObscureText() {
    _obscureText = !obscureText;
    notifyListeners();
  }

  void swipLogin() {
    _valid = false;
    _isLogin = !isLogin;
    notifyListeners();
  }

  void singUp(
      BuildContext context, String name, String email, String password) async {
    _valid = true;
    notifyListeners();
    final result = await singUpAuth.execute(name, email, password);
    result.fold((l) {
      _valid = false;
      _message = l.message;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l.message),
      ));
      notifyListeners();
    }, (r) {
      _valid = false;
      Navigator.pushNamedAndRemoveUntil(context, HomePage.route,ModalRoute.withName('/'));
      notifyListeners();
    });
  }

  void login(BuildContext context, String email, String password) async {  
    _valid = true;
    notifyListeners();
    final result = await loginAuth.execute(email: email, password: password);
    result.fold((l) {
      _valid = false;
      _message = l.message;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l.message),
      ));
      notifyListeners();
    }, (r) {
      _valid = false;
      helperLocal.saveLogin(login: true);
      Navigator.pushNamedAndRemoveUntil(context, HomePage.route,ModalRoute.withName('/'));
      notifyListeners();
    });
  }
}
