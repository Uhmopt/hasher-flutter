import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:http/http.dart' as http;

Future<Result> updateAttend({
  String club = '',
  String stat = 'regi',
  String hasher = '',
  String runid = '',
  String rundate = '',
  String runtime = '',
}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['stat'] = stat;
  data['hasher'] = hasher;
  data['club'] = club;
  data['runid'] = runid;
  data['rundate'] = rundate;
  data['runtime'] = runtime;

  final response = await http.post(
    Uri.parse(apiBase + '/runattend_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('updateAttend: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Result(status: FAIL);
    }
  } else {
    return Result(status: FAIL);
  }
}
