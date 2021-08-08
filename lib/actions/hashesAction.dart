import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:http/http.dart' as http;

Future<Hashes> getMyHashes(String email) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['email'] = email;

  final response = await http.post(
    Uri.parse(apiBase + '/myclubs_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('getMyHashes: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return Hashes.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Hashes(status: FAIL);
    }
  } else {
    return Hashes(status: FAIL);
    // throw Exception('Failed to create Hashes.');
  }
}

class Hash {
  bool current = false;
  bool last = false;
  bool mother = false;
  bool committee = false;
  bool follow = false;
  String country = '';
  // ignore: non_constant_identifier_names
  int total_runs = 0;
  // ignore: non_constant_identifier_names
  String first_runs = '';
  // ignore: non_constant_identifier_names
  String run_area = '';
  String hashclubname = '';
  String rundate = '';
  int runnumber = 0;
  int clubid = 0;

  Hash({
    this.current = false,
    this.last = false,
    this.mother = false,
    this.committee = false,
    this.follow = false,
    this.country = '',
    // ignore: non_constant_identifier_names
    this.total_runs = 0,
    // ignore: non_constant_identifier_names
    this.first_runs = '',
    // ignore: non_constant_identifier_names
    this.run_area = '',
    this.hashclubname = '',
    this.rundate = '',
    this.runnumber = 0,
    this.clubid = 0,
  });

  factory Hash.fromJson(Map<String, dynamic> json) {
    return Hash(
      current: int.parse(json['current'] ?? '0') == 1,
      last: int.parse(json['last'] ?? '0') == 1,
      mother: int.parse(json['mother'] ?? '0') == 1,
      committee: int.parse(json['committee'] ?? '0') == 1,
      follow: int.parse(json['follow'] ?? '0') == 1,
      country: (json['country'] ?? '').toString(),
      total_runs: int.parse(json['total_runs'] ?? '0'),
      first_runs: (json['first_runs'] ?? '').toString(),
      run_area: (json['run_area'] ?? '').toString(),
      hashclubname: (json['hashclubname'] ?? '').toString(),
      rundate: (json['rundate'] ?? '').toString(),
      runnumber: int.parse(json['runnumber'] ?? '0'),
      clubid: int.parse(json['clubid'] ?? '0'),
    );
  }
}

class Hashes {
  String status = FAIL;
  String email = '';
  String hashname = '';
  String base64image = '';
  List<Hash>? hashes;

  Hashes({
    required this.status,
    this.email = '',
    this.hashname = '',
    this.base64image = '',
    this.hashes,
  });

  factory Hashes.fromJson(Map<String, dynamic> json) {
    return Hashes(
      status: json['status'] ?? FAIL,
      email: json['email'] ?? '',
      hashname: json['hashname'] ?? '',
      base64image: json['base64image'] ?? '',
      hashes:
          List<Hash>.from(json['hashes'].map((item) => Hash.fromJson(item))),
    );
  }
}
