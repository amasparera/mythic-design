import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/api_url.dart';
import '../../common/exception.dart';
import '../models/product_model.dart';

// class repository utama

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({required int page});
  Future<ProductModel> getProductDetail({required String productId});
}

// class implement
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiUrl apiUrl;
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client, required this.apiUrl});

  @override
  Future<List<ProductModel>> getProducts({required int page}) async {
    final respone = await client
        .get(Uri.parse(apiUrl.baseUrl + apiUrl.getProducts + page.toString()));
    var body = jsonDecode(respone.body);

    if (respone.statusCode == 200) {
      return List<ProductModel>.from(
          (body["data"] as List<dynamic>).map((x) => ProductModel.fromjson(x,null)));
    } else {
      throw ServerException(message: body["message"]);
    }
    
  }

  @override
  Future<ProductModel> getProductDetail({required String productId}) async {
    final respone = await client
        .get(Uri.parse(apiUrl.baseUrl + apiUrl.getProductDetail + productId));
    var body = jsonDecode(respone.body);

    if (respone.statusCode == 200 && body != null) {
      return ProductModel.fromjson(body["data"],body["image"]);
    } else {
      throw ServerException(message: body["message"]);
    }
  }
}
