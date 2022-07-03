import 'dart:convert';

import 'package:http/http.dart';

import '../../common/api_url.dart';
import '../models/wishlist_model.dart';

abstract class WishlistRemoteSource {
  Future<String> wishlistAdd(Map<String, dynamic> map);
  Future<String> wishlistDelete(String idWishlist);
  Future<List<WishlistModel>> wishlistRead(String idUser);
}

class WishlistRemoteSourceImpl implements WishlistRemoteSource {
  final Client client;
  final ApiUrl apiUrl;

  WishlistRemoteSourceImpl(this.client, this.apiUrl);

  @override
  Future<String> wishlistAdd(Map<String, dynamic> map) async {
    Uri api = Uri.parse("${apiUrl.baseUrl}${apiUrl.wishlistAdd}");
    final result = await client.post(api, body: map);
    final body = jsonDecode(result.body);

    if (result.statusCode == 200) {
      return body["message"];
    } else {
      throw Exception(body["message"]);
    }
  }

  @override
  Future<String> wishlistDelete(String idWishlist) async {
    Uri api = Uri.parse(apiUrl.baseUrl + apiUrl.wishlistDelete + idWishlist);
    final result = await client.delete(api);
    final body = jsonDecode(result.body);

    if (result.statusCode == 200) {
      return body["message"];
    } else {
      throw Exception(body["message"]);
    }
  }

  @override
  Future<List<WishlistModel>> wishlistRead(String idUser) async {
    Uri api = Uri.parse(apiUrl.baseUrl + apiUrl.wishlistRead + idUser);
    final result = await client.get(api);
    final body = jsonDecode(result.body);

    if (result.statusCode == 200) {
      return List<WishlistModel>.from((body["data"] as List<dynamic>)
          .map((x) => WishlistModel.fromjson(x)));
    } else {
      throw Exception(body["message"]);
    }
  }
}
