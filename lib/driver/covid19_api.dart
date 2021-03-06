import 'dart:convert';

import 'package:myapp/total_json.dart';
import 'package:http/http.dart' as http;

class Covid19Api {

  Future<List<TotalJson>> requestTotalHistory() async {
    final response = await http.get(Uri.https('covid19-japan-web-api.now.sh', '/api/v1/total', { "history" : "true"}));
    return (jsonDecode(response.body) as List).map((e) => TotalJson.fromJson(e)).toList();
  }

  Future<TotalJson> totalCount() async {
    final response = await http.get(Uri.https('covid19-japan-web-api.now.sh', '/api/v1/total'));
    return TotalJson.fromJson(jsonDecode(response.body));
  }
}