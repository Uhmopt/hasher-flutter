import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/config.dart';
import 'package:http/http.dart' as http;

Future<List<String>> getClubHare(String club) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['club'] = club;

  final response = await http.post(
    Uri.parse(apiBase + '/hare_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('getClubHare: ' + response.body);
  if (response.statusCode == 200) {
    try {
      List<String> t = List<String>.from(
          jsonDecode(response.body)['hasher'].map((item) => (item).toString()));
      t.sort((a, b) {
        return a.compareTo(b);
      });
      return t;
    } catch (e) {
      return [];
    }
  } else {
    return [];
    // throw Exception('Failed to create Hares.');
  }
}
