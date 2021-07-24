import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/config.dart';
import 'package:http/http.dart' as http;

Future<List<String>> getCountries() async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  final response = await http.get(
    Uri.parse(apiBase + '/country_mo.php'),
    headers: headers,
  );

  log('getCountries: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return List<String>.from(
          jsonDecode(response.body).map((item) => (item).toString()));
    } catch (e) {
      return [];
    }
  } else {
    return [];
    // throw Exception('Failed to create Countries.');
  }
}
