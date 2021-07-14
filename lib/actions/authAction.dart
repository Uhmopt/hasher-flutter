import 'dart:async';
import 'dart:convert';
import 'package:hasher/config.dart';
import 'package:http/http.dart' as http;

Future<Result> loginAction(String email, String password) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['email'] = email;
  data['password'] = password;

  final response = await http.post(
    Uri.parse(apiBase + '/signin_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  if (response.statusCode == 200) {
    try {
      return Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Result(status: 'fail');
    }
  } else {
    return Result(status: 'fail');
    // throw Exception('Failed to create Result.');
  }
}

Future<Result> signUpAction(
  String first,
  String last,
  String hash,
  String email,
  String phone,
  String birth,
  String firstrun,
  String password,
  String base64image,
) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['first'] = first;
  data['last'] = last;
  data['hash'] = hash;
  data['email'] = email;
  data['phone'] = phone;
  data['birth'] = birth;
  data['firstrun'] = firstrun;
  data['base64image'] = base64image;
  data['password'] = password;

  final response = await http.post(
    Uri.parse(apiBase + '/signup_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  if (response.statusCode == 200) {
    try {
      return Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Result(status: 'fail');
    }
  } else {
    return Result(status: 'fail');
    // throw Exception('Failed to create Result.');
  }
}

class Result {
  final String status;

  Result({required this.status});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      status: json['status'],
    );
  }
}
