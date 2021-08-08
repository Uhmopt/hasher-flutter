import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:http/http.dart' as http;

Future<List<String>> getClubNames(String country) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['country'] = country;

  final response = await http.post(
    Uri.parse(apiBase + '/clubs_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('getClubNames: ' + response.body);
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

Future<Result> selectClubAction(
    {String country = '',
    String curhashclub = '',
    String curtotalrun = '',
    String roles = '',
    String email = ''}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['country'] = country;
  data['curhashclub'] = curhashclub;
  data['curtotalrun'] = curtotalrun;
  data['roles'] = roles;
  data['email'] = email;

  final response = await http.post(
    Uri.parse(apiBase + '/selhashclub_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('selectClubAction: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return new Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new Result(status: FAIL);
    }
  } else {
    return new Result(status: FAIL);
    // throw Exception('Failed to create Countries.');
  }
}

Future<Result> createClub(
    {String country = '',
    String runarea = '',
    String clubname = '',
    String firstrun = '',
    String currunnum = '',
    String rundate = ''}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['country'] = country;
  data['runarea'] = runarea;
  data['clubname'] = clubname;
  data['firstrun'] = firstrun;
  data['currunnum'] = currunnum;
  data['rundate'] = rundate;

  final response = await http.post(
    Uri.parse(apiBase + '/createhashclub_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('createClub: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return new Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new Result(status: FAIL);
    }
  } else {
    return new Result(status: FAIL);
    // throw Exception('Failed to create Countries.');
  }
}
