import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/models.dart';
import '../../uitilities/end_points.dart';
import 'deeze_state.dart';

class DeezeRepository {
  Future<DeezeState> getCategories(String type) async {
    var url = getDeezeAppUrlContent;

    Uri uri = Uri.parse(url).replace(queryParameters: {
      "page": "1",
      "itemsPerPage": "10",
      "enabled": "true",
      "type": type
    });
    try {
      http.Response response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        var rawResponse = deezeFromJson(response.body);
        return LoadedDeeze(deeze: rawResponse);
      } else {
        return const ErrorDeeze();
      }
    } catch (e) {
      return const ErrorDeeze();
    }
  }
}
