import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/actions/hashesAction.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:http/http.dart' as http;

Future<Hasher> basicHasherInfo(String email) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['email'] = email;

  final response = await http.post(
    Uri.parse(apiBase + '/mainmenu_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('basicHasherInfo: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return Hasher.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Hasher(status: FAIL);
    }
  } else {
    return Hasher(status: FAIL);
    // throw Exception('Failed to create Hasher.');
  }
}

class Hasher {
  String status = FAIL;
  int id = 0;
  String email = '';
  String hashname = '';
  String base64image = '';
  List<Hash>? hashes;
  // List<dynamic> toruns = [];

  Hasher({
    required this.status,
    this.id = 0,
    this.email = '',
    this.hashname = '',
    this.base64image = '',
    this.hashes,
  });

  factory Hasher.fromJson(Map<String, dynamic> json) {
    return Hasher(
        status: json['status'] ?? FAIL,
        id: int.parse(json['id'] ?? '0'),
        email: json['email'] ?? '',
        hashname: json['hashname'] ?? '',
        base64image: json['base64image'] ?? '',
        hashes:
            List<Hash>.from(json['hashes'].map((item) => Hash.fromJson(item))));
  }

  Map<String, dynamic> toJson() {
    return {
      'status': this.status,
      'id': this.id,
      'email': this.email,
      'hashname': this.hashname,
      'base64image': this.base64image,
    };
  }
}
