import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:http/http.dart' as http;

Future<Result> addCoHare({String hashrunid = '', String cohare = ''}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['hashrunid'] = hashrunid;
  data['cohare'] = cohare;

  final response = await http.post(
    Uri.parse(apiBase + '/addcohare_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('addCoHare: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Result(status: FAIL);
    }
  } else {
    return Result(status: FAIL);
    // throw Exception('Failed to create Hares.');
  }
}

Future<Result> deleteCoHare({String hashrunid = '', String cohare = ''}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['hashrunid'] = hashrunid;
  data['cohare'] = cohare;

  final response = await http.post(
    Uri.parse(apiBase + '/delcohare_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('addCoHare: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Result(status: FAIL);
    }
  } else {
    return Result(status: FAIL);
    // throw Exception('Failed to create Hares.');
  }
}

Future<List<String>> getCoHares({String hashrunid = ''}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['hashrunid'] = hashrunid;

  final response = await http.post(
    Uri.parse(apiBase + '/cohare_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('getCoHares: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return List<String>.from(
        jsonDecode(response.body).map((item) => (item).toString()),
      );
    } catch (e) {
      return [];
    }
  } else {
    return [];
    // throw Exception('Failed to create Hares.');
  }
}
