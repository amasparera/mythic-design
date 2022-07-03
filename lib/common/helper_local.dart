import 'package:shared_preferences/shared_preferences.dart';

class HelperLocal {
  // KEY
  final String keyFavorite = "KEY_FAVORITE";
  final String keyLogin = "KEY_LOGIN";
  final String keyInstal = "KEY_INSTAL";
  final String keyProfileId = "KEY_PROFILE_ID";
  final String keyToken = "KEY_TOKEN";
  final String keyProfileImage = "KEY_PROFILE_IMAGE";

  // reset
  resetData()async{
    final local = await SharedPreferences.getInstance();
    local.clear();
    saveInstal(instal: true);
  }

  // save
  saveFavorite(List<String> listIdFavorite) async {
    final local = await SharedPreferences.getInstance();
    await local.setStringList(keyFavorite, listIdFavorite);
  }

  saveLogin({required bool login}) async {
    final local = await SharedPreferences.getInstance();
    await local.setBool(keyLogin, login);
  }

  saveInstal({required bool instal}) async {
    final local = await SharedPreferences.getInstance();
    await local.setBool(keyInstal, instal);
  }

  saveProfileImage({required String image}) async {
    final local = await SharedPreferences.getInstance();
    await local.setString(keyProfileImage, image);
  }

  saveProfileId({required String id}) async {
    final local = await SharedPreferences.getInstance();
    await local.setString(keyProfileId, id);
  }

  saveToken({required String token}) async {
    final local = await SharedPreferences.getInstance();
    await local.setString(keyToken, token);
  }

  // load
  Future<List<String>?> loadFavorite() async {
    final local = await SharedPreferences.getInstance();
    return local.getStringList(keyFavorite);
  }

  Future<bool> loadLogin() async {
    final local = await SharedPreferences.getInstance();
    return local.getBool(keyLogin) ?? false;
  }

  Future<bool> loadInstal() async {
    final local = await SharedPreferences.getInstance();
    return local.getBool(keyInstal) ?? false;
  }

  Future<String?> loadProfileImage() async {
    final local = await SharedPreferences.getInstance();
    return local.getString(keyProfileImage);
  }

  Future<String?> loadProfileId() async {
    final local = await SharedPreferences.getInstance();
    return local.getString(keyProfileId);
  }

  Future<String?> loadToken()async {
    final local = await SharedPreferences.getInstance();
    return local.getString(keyToken);
  }
}
