import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/config.dart';
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

  log(response.body);
  if (response.statusCode == 200) {
    try {
      return Hasher.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Hasher(status: 'fail');
    }
  } else {
    return Hasher(status: 'fail');
    // throw Exception('Failed to create Hasher.');
  }
}

class Hasher {
  String status = 'fail';
  int id = 0;
  String email = '';
  String hashname = '';
  String base64image = '';
  List<dynamic> hashes = [];
  List<dynamic> toruns = [];

  Hasher({
    required this.status,
    this.id = 0,
    this.email = '',
    this.hashname = '',
    this.base64image = '',
  });

  factory Hasher.fromJson(Map<String, dynamic> json) {
    return Hasher(
      status: json['status'] ?? 'fail',
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      hashname: json['hashname'] ?? '',
      base64image: json['base64image'] ?? '',
    );
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
