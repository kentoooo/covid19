import 'dart:convert';

import 'package:myapp/total_json.dart';
import 'package:http/http.dart' as http;

class Covid19Api {

  Future<List<TotalJson>> requestTotalHistory() async {
    //final url = 'https://covid19-japan-web-api.now.sh/api/v1/total?history=true';
    final url = 'http://localhost:8080/api/v1/total?history=true';
    final response = await http.get(url);
    return (jsonDecode(response.body) as List).map((e) => TotalJson.fromJson(e)).toList();
  }

  Future<TotalJson> totalCount() async {
    //final url = 'https://covid19-japan-web-api.now.sh/api/v1/total';
    final url = 'http://localhost:8080/api/v1/total';
    final response = await http.get(url);
    print(response.body);
    return TotalJson.fromJson(jsonDecode(response.body));
  }
}