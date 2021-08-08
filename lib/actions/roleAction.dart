import 'dart:convert';
import 'dart:developer';

import 'package:hasher/actions/authAction.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:http/http.dart' as http;

Future<Result> updateRoleAction(
    {String club = '',
    String email = '',
    String total = '',
    bool current = false,
    bool follow = false}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['club'] = club;
  data['email'] = email;
  data['total'] = total;
  data['current'] = current.toString();
  data['follow'] = follow.toString();

  final response = await http.post(
    Uri.parse(apiBase + '/roleedit_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );
  log('updatedRoleAction: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return new Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new Result(status: FAIL);
    }
  } else {
    return new Result(status: FAIL);
    // throw Exception('Failed to create Result.');
  }
}
