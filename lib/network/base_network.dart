import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseNetwork {
  static const String baseUrl = "https://681388b3129f6313e2119693.mockapi.io/api/v1/";

  static Future<List<dynamic>> getData(String endpoint) async{
    final response = await http.get(Uri.parse(baseUrl + endpoint));
    //print('API Response Body: ${response.body}');
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      print(data);
      return data ?? [];
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<Map<String, dynamic>> getDetailData(String endpoint, String id) async{
    final response = await http.get(Uri.parse(baseUrl + '$endpoint/$id'));
    print('API Response Body: ${response.body}');
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load detail data');
    }
  }
}