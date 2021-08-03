import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:hasher/actions/runDetailAction.dart';
import 'package:hasher/config.dart';
import 'package:http/http.dart' as http;

Future<RunList> getRunList({String club = '', String email = ''}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['club'] = club;
  data['email'] = email;

  final response = await http.post(
    Uri.parse(apiBase + '/runlist_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );
  log('getRunList: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return new RunList.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new RunList(status: 'fail');
    }
  } else {
    return new RunList(status: 'fail');
    // throw Exception('Failed to create RunList.');
  }
}

class Run {
  String email = "";
  String run_number = "";
  String run_date = "";
  String run_time = "";
  String hashrunid = "";

  Run({
    this.email = "",
    this.run_number = "",
    this.run_date = "",
    this.run_time = "",
    this.hashrunid = "",
  });

  factory Run.fromJson(Map<String, dynamic> json) {
    return new Run(
      email: json['email'] ?? "",
      run_number: json['run_number'] ?? "",
      run_date: json['run_date'] ?? "",
      run_time: json['run_time'] ?? "",
      hashrunid: json['hashrunid'] ?? "",
    );
  }
}

class RunList {
  String status = 'fail';
  List<Run>? runlist = [];
  String total = '';

  RunList({
    this.status = 'fail',
    this.runlist,
    this.total = '',
  });

  factory RunList.fromJson(Map<String, dynamic> json) {
    return new RunList(
      status: json['status'] ?? "",
      runlist:
          List<Run>.from(json['runlist'].map((item) => new Run.fromJson(item))),
      total: json['total'] ?? "",
    );
  }
}
