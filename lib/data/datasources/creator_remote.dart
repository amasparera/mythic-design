import 'dart:convert';


import 'package:http/http.dart' as http;

import '../../common/api_url.dart';
import '../../common/exception.dart';
import '../models/creator_model.dart';
import '../models/product_media_image_model.dart';

abstract class CreatorRemoteRepository {
  Future<CreatorModel> getCreator(String id);
  Future<List<ProductMediaImageModel>> getCreatorCollection(String id);
}

class CreatorRemoteRepositoryImpl implements CreatorRemoteRepository {
  final http.Client client;
  final ApiUrl apiUrl;

  CreatorRemoteRepositoryImpl(this.client, this.apiUrl);
  @override
  Future<CreatorModel> getCreator(String id) async {
    Uri api = Uri.parse("${apiUrl.baseUrl}${apiUrl.getCreator}$id");
    final result = await client.get(api);
    var body = jsonDecode(result.body);

    if (result.statusCode == 200) {
      return CreatorModel.fromjson(body["data"]);
    } else {
      throw ServerException(message: body["message"]);
    }
  }

  @override
  Future<List<ProductMediaImageModel>> getCreatorCollection(String id) async {
    Uri api = Uri.parse("${apiUrl.baseUrl}${apiUrl.getCreatorCollection}$id");
    final result = await client.get(api);
    var body = jsonDecode(result.body);

    if (result.statusCode == 200) {
      return List<ProductMediaImageModel>.from((body["data"] as List<dynamic>)
          .map((e) => ProductMediaImageModel.fromjson(e)));
    } else {
      throw ServerException(message: body["message"]);
    }
  }
}
