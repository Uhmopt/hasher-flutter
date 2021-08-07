import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:hasher/config.dart';
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
      return new RunDetail(status: 'fail');
    }
  } else {
    return new RunDetail(status: 'fail');
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
      return new RunDetail(status: 'fail');
    }
  } else {
    return new RunDetail(status: 'fail');
    // throw Exception('Failed to create RunDetail.');
  }
}

class RunDetail {
  String status = 'fail';
  String rundate = '';
  String runtime = '';
  String runnum = '';
  String location = '';
  String direction = '';
  String onon = '';
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
    this.status = 'fail',
    this.rundate = '',
    this.runtime = '',
    this.runnum = '',
    this.location = '',
    this.direction = '',
    this.onon = '',
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
      onon: json['onon'] ?? "",
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
