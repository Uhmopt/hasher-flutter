import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:hasher/actions/authAction.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
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
      return new RunList(status: FAIL);
    }
  } else {
    return new RunList(status: FAIL);
    // throw Exception('Failed to create RunList.');
  }
}

Future<HareRunList> getHareRunList({String club = ''}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['club'] = club;

  final response = await http.post(
    Uri.parse(apiBase + '/hares_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );
  log('getHareRunList: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return new HareRunList.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new HareRunList();
    }
  } else {
    return new HareRunList();
    // throw Exception('Failed to create RunList.');
  }
}

class Run {
  String email = "";
  String runnumber = "";
  String rundate = "";
  String runtime = "";
  String hashrunid = "";
  String hashname = "";

  Run({
    this.email = "",
    this.runnumber = "",
    this.rundate = "",
    this.runtime = "",
    this.hashrunid = "",
    this.hashname = "",
  });

  factory Run.fromJson(Map<String, dynamic> json) {
    return new Run(
      email: json['email'] ?? "",
      runnumber: json['run_number'] ?? json['runnumber'] ?? "",
      rundate: json['run_date'] ?? json['rundate'] ?? "",
      runtime: json['run_time'] ?? json['runtime'] ?? "",
      hashrunid: json['hashrunid'] ?? "",
      hashname: json['hashname'] ?? "",
    );
  }
}

Future<Result> addHareRun({
  String runnumber = '',
  String rundate = '',
  String runtime = '',
  String hare = '',
  String club = '',
}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['runnumber'] = runnumber;
  data['rundate'] = rundate;
  data['runtime'] = runtime;
  data['hare'] = hare;
  data['club'] = club;

  final response = await http.post(
    Uri.parse(apiBase + '/addrun_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );
  log('addHareRun: ' + response.body);
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

Future<Result> updateHareRun({
  String hashrunid = '',
  String rundate = '',
  String runtime = '',
  String hare = '',
}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['hashrunid'] = hashrunid;
  data['rundate'] = rundate;
  data['runtime'] = runtime;
  data['hare'] = hare;

  final response = await http.post(
    Uri.parse(apiBase + '/updaterun_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );
  log('updateHareRun: ' + response.body);
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

class RunList {
  String status = FAIL;
  List<Run>? runlist = [];
  String total = '';

  RunList({
    this.status = FAIL,
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

class HareRunList {
  List<Run>? hares = [];
  List<String>? committee = [];

  HareRunList({
    this.hares,
    this.committee,
  });

  factory HareRunList.fromJson(Map<String, dynamic> json) {
    return new HareRunList(
      hares:
          List<Run>.from(json['hares'].map((item) => new Run.fromJson(item))),
      committee: List<String>.from(
          json['committee'].map((item) => (item ?? '').toString())),
    );
  }
}
