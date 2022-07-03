import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart' as http;

import '../../common/api_url.dart';
import '../../common/exception.dart';
import '../../common/helper_local.dart';
import '../models/user_model.dart';

abstract class AuthRemoteRepository {
  Future<UserModel?> singUp({required Map<String, dynamic> map});
  Future<UserModel?> logIn({required Map<String, dynamic> map});
}

class AuthRemoteRepositoryImpl implements AuthRemoteRepository {
  final http.Client client;
  final ApiUrl apiUrl;
  final HelperLocal local;

  AuthRemoteRepositoryImpl(this.client, this.apiUrl, this.local);

  @override
  Future<UserModel?> logIn({required Map<String, dynamic> map}) async {
    log(map.toString());
    Uri api = Uri.parse(apiUrl.baseUrl + apiUrl.login);
    var json = await client.post(api, body: map);
    var body = jsonDecode(json.body);
    log(body.toString());
    if (json.statusCode == 200) {
      local.saveLogin(login: true);
      local.saveToken(token: body["accestoken"]);
      local.saveProfileId(id: body["data"]["id"].toString());
      local.saveProfileImage(image: body["data"]["image"]);
      return UserModel.fromjson(body["data"]);
    } else {
      throw ServerException(message: body["message"]);
    }
  }

  @override
  Future<UserModel> singUp({required Map<String, dynamic> map}) async {
    log(map.toString());
    Uri api = Uri.parse(apiUrl.baseUrl + apiUrl.singUp);
    var json = await client.post(api, body: map);
    var body = jsonDecode(json.body);
    log(body.toString());

    if (json.statusCode == 200) {
      local.saveLogin(login: true);
      local.saveToken(token: body["accestoken"]);
      local.saveProfileId(id: body["data"]["id"].toString());
      local.saveProfileImage(image: body["data"]["image"]);
      return UserModel.fromjson(body["data"]);
    } else {
      throw ServerException(message: body["message"]);
    }
  }
}
