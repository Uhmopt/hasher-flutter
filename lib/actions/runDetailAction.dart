import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:hasher/actions/authAction.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:http/http.dart' as http;

Future<RunDetail> getRunDetail(
    {String club = '', String hashrunid = 'next', String email = ''}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['club'] = club;
  data['hashrunid'] = hashrunid;
  data['email'] = email;

  final response = await http.post(
    Uri.parse(apiBase + '/rundetail_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );
  log('getRunDetail: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return new RunDetail.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new RunDetail(status: FAIL);
    }
  } else {
    return new RunDetail(status: FAIL);
    // throw Exception('Failed to create RunDetail.');
  }
}

Future<RunDetail> updateRunDetail(
    {String club = '', String hashrunid = 'next', String email = ''}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['club'] = club;
  data['hashrunid'] = hashrunid;
  data['email'] = email;

  final response = await http.post(
    Uri.parse(apiBase + '/rundetail_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );
  log('getRunDetail: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return new RunDetail.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new RunDetail(status: FAIL);
    }
  } else {
    return new RunDetail(status: FAIL);
    // throw Exception('Failed to create RunDetail.');
  }
}

Future<Result> addRunDetail({
  String club = '',
  String runnumber = '',
  String rundate = '',
  String runtime = '',
  String latitude = '',
  String longitude = '',
  String direction = '',
  String onon = '',
  String confirm = '',
  String ondesc = '',
}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['club'] = club;
  data['runnumber'] = runnumber;
  data['rundate'] = rundate;
  data['runtime'] = runtime;
  data['latitude'] = latitude;
  data['longitude'] = longitude;
  data['direction'] = direction;
  data['onon'] = onon == 'Yes' ? '1' : '0';
  data['confirm'] = confirm;
  data['ondesc'] = ondesc;

  final response = await http.post(
    Uri.parse(apiBase + '/adddetail_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );
  log('addRunDetail: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return new Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new Result(status: FAIL);
    }
  } else {
    return new Result(status: FAIL);
    // throw Exception('Failed to create RunList.');
  }
}

class RunDetail {
  String status = FAIL;
  String rundate = '';
  String runtime = '';
  String runnum = '';
  String location = '';
  String direction = '';
  bool onon = false;
  String onfee = '';
  String longitude = '';
  String latitude = '';
  String hare = '';
  List<String>? cohare = [];
  String id = '';
  String ondesc = '';
  List<String>? conatt = [];
  List<String>? cononon = [];
  String runattend = '';

  RunDetail({
    this.status = FAIL,
    this.rundate = '',
    this.runtime = '',
    this.runnum = '',
    this.location = '',
    this.direction = '',
    this.onon = false,
    this.onfee = '',
    this.longitude = '',
    this.latitude = '',
    this.hare = '',
    this.cohare,
    this.id = '',
    this.ondesc = '',
    this.conatt,
    this.cononon,
    this.runattend = '',
  });

  factory RunDetail.fromJson(Map<String, dynamic> json) {
    return new RunDetail(
      status: json['status'] ?? "",
      rundate: json['rundate'] ?? "",
      runtime: json['runtime'] ?? "",
      runnum: json['runnum'] ?? "",
      location: json['location'] ?? "",
      direction: json['direction'] ?? "",
      onon: int.parse(json['onon'] ?? "0").abs() > 0,
      onfee: json['onfee'] ?? "",
      longitude: json['longitude'] ?? "",
      latitude: json['latitude'] ?? "",
      hare: json['hare'] ?? "",
      cohare: List<String>.from(json['cohare'].map((item) => item.toString())),
      id: json['id'] ?? "",
      ondesc: json['ondesc'] ?? "",
      conatt: List<String>.from(json['conatt'].map((item) => item.toString())),
      cononon:
          List<String>.from(json['cononon'].map((item) => item.toString())),
      runattend: json['runattend'] ?? "",
    );
  }
}
