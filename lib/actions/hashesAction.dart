import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/config.dart';
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

  log(response.body);
  if (response.statusCode == 200) {
    try {
      return Hashes.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Hashes(status: 'fail');
    }
  } else {
    return Hashes(status: 'fail');
    // throw Exception('Failed to create Hashes.');
  }
}

class Hash {
  int total_runs = 0;
  String hashclubname = '';
  String rundate = '';
  int runnumber = 0;
  int clubid = 0;

  Hash({
    this.total_runs = 0,
    this.hashclubname = '',
    this.rundate = '',
    this.runnumber = 0,
    this.clubid = 0,
  });

  factory Hash.fromJson(Map<String, dynamic> json) {
    return Hash(
      total_runs: int.parse(json['total_runs'] ?? ''),
      hashclubname: json['hashclubname'] ?? '',
      rundate: json['rundate'] ?? '',
      runnumber: int.parse(json['runnumber'] ?? ''),
      clubid: int.parse(json['clubid'] ?? ''),
    );
  }
}

class Hashes {
  String status = 'fail';
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
      status: json['status'] ?? 'fail',
      email: json['email'] ?? '',
      hashname: json['hashname'] ?? '',
      base64image: json['base64image'] ?? '',
      hashes:
          List<Hash>.from(json['hashes'].map((item) => Hash.fromJson(item))),
    );
  }
}
