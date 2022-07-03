import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/api_url.dart';
import '../../common/exception.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser({required String userId});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final ApiUrl apiUrl;
  UserRemoteDataSourceImpl({required this.client, required this.apiUrl});

  @override
  Future<UserModel> getUser({required String userId}) async {
    final respone =
        await client.get(Uri.parse(apiUrl.baseUrl + apiUrl.getUser + userId));

    var json = jsonDecode(respone.body);

    if (respone.statusCode == 200) {
      return UserModel.fromjson(json["data"]);
    } else {
      throw ServerException(message: json["message"]);
    }
  }
}
