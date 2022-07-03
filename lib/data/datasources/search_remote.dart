import 'dart:convert';

import 'package:http/http.dart';

import '../../common/api_url.dart';
import '../../common/exception.dart';
import '../models/product_media_image_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<ProductMediaImageModel>> searchProduct(String productName);
  Future<List<ProductMediaImageModel>> searchPopular();
  Future<List<ProductMediaImageModel>> searchNew();
  Future<List<ProductMediaImageModel>> searchHighPrice();
  Future<List<ProductMediaImageModel>> searchLowPrice();
  Future<List<ProductMediaImageModel>> searchCosplay();
  Future<List<ProductMediaImageModel>> searchIlustration();
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiUrl apiUrl;
  final Client client;

  SearchRemoteDataSourceImpl(this.apiUrl, this.client);

  @override
  Future<List<ProductMediaImageModel>> searchCosplay() async {
    final respone = await client
        .get(Uri.parse(apiUrl.baseUrl + apiUrl.searchProductCosplay));
    var body = jsonDecode(respone.body);
    if (respone.statusCode == 200) {
      return List<ProductMediaImageModel>.from((body["data"] as List<dynamic>)
          .map((x) => ProductMediaImageModel.fromjson(x)));
    } else {
      throw ServerException(message: body["message"]);
    }
  }

  @override
  Future<List<ProductMediaImageModel>> searchHighPrice() async {
    final respone = await client
        .get(Uri.parse(apiUrl.baseUrl + apiUrl.searchProductHighPrice));
    var body = jsonDecode(respone.body);
    if (respone.statusCode == 200) {
      return List<ProductMediaImageModel>.from((body["data"] as List<dynamic>)
          .map((x) => ProductMediaImageModel.fromjson(x)));
    } else {
      throw ServerException(message: body["message"]);
    }
  }

  @override
  Future<List<ProductMediaImageModel>> searchIlustration() async {
    final respone = await client
        .get(Uri.parse(apiUrl.baseUrl + apiUrl.searchProductIllustration));
    var body = jsonDecode(respone.body);
    if (respone.statusCode == 200) {
      return List<ProductMediaImageModel>.from((body["data"] as List<dynamic>)
          .map((x) => ProductMediaImageModel.fromjson(x)));
    } else {
      throw ServerException(message: body["message"]);
    }
  }

  @override
  Future<List<ProductMediaImageModel>> searchLowPrice() async {
    final respone = await client
        .get(Uri.parse(apiUrl.baseUrl + apiUrl.searchProductLowPrice));
    var body = jsonDecode(respone.body);
    if (respone.statusCode == 200) {
      return List<ProductMediaImageModel>.from((body["data"] as List<dynamic>)
          .map((x) => ProductMediaImageModel.fromjson(x)));
    } else {
      throw ServerException(message: body["message"]);
    }
  }

  @override
  Future<List<ProductMediaImageModel>> searchNew() async {
    final respone =
        await client.get(Uri.parse(apiUrl.baseUrl + apiUrl.searchProductNew));
    var body = jsonDecode(respone.body);
    if (respone.statusCode == 200) {
      return List<ProductMediaImageModel>.from((body["data"] as List<dynamic>)
          .map((x) => ProductMediaImageModel.fromjson(x)));
    } else {
      throw ServerException(message: body["message"]);
    }
  }

  @override
  Future<List<ProductMediaImageModel>> searchPopular() async {
    final respone = await client
        .get(Uri.parse(apiUrl.baseUrl + apiUrl.searchProductPopuler));
    var body = jsonDecode(respone.body);
    if (respone.statusCode == 200) {
      return List<ProductMediaImageModel>.from((body["data"] as List<dynamic>)
          .map((x) => ProductMediaImageModel.fromjson(x)));
    } else {
      throw ServerException(message: body["message"]);
    }
  }

  @override
  Future<List<ProductMediaImageModel>> searchProduct(String productName) async {
    final respone =
        await client.get(Uri.parse(apiUrl.baseUrl + apiUrl.searchProduct));
    var body = jsonDecode(respone.body);
    if (respone.statusCode == 200) {
      return List<ProductMediaImageModel>.from((body["data"] as List<dynamic>)
          .map((x) => ProductMediaImageModel.fromjson(x)));
    } else {
      throw ServerException(message: body["message"]);
    }
  }
}
