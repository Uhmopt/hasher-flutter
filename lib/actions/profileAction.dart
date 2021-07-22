import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/actions/authAction.dart';
import 'package:hasher/config.dart';
import 'package:http/http.dart' as http;

Future<Profiles> getProfiles(String email) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['email'] = email;

  final response = await http.post(
    Uri.parse(apiBase + '/profile_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('getProfiles: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return Profiles.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Profiles(status: 'fail');
    }
  } else {
    return Profiles(status: 'fail');
    // throw Exception('Failed to create Profiles.');
  }
}

Future<Result> updateProfileAction({
  int? id,
  String? first,
  String? last,
  String? hash,
  String? email,
  String? phone,
  String? birth,
  String? firstrun,
  String? base64image,
}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['id'] = id.toString();
  data['first'] = first ?? '';
  data['last'] = last ?? '';
  data['hash'] = hash ?? '';
  data['email'] = email ?? '';
  data['phone'] = phone ?? '';
  data['birth'] = birth ?? '';
  data['firstrun'] = firstrun ?? '';
  data['base64image'] = base64image ?? '';

  final response = await http.post(
    Uri.parse(apiBase + '/update_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('updateProfileAction: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Result(status: 'fail');
    }
  } else {
    return Result(status: 'fail');
    // throw Exception('Failed to create Profiles.');
  }
}

Future<Result> updatePasswordAction({
  String? email,
  String? password,
  String? oldpass,
}) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['email'] = email ?? '';
  data['password'] = password ?? '';
  data['oldpass'] = oldpass ?? '';

  final response = await http.post(
    Uri.parse(apiBase + '/reset_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );

  log('updatePasswordAction: ' + response.body);
  if (response.statusCode == 200) {
    try {
      return Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Result(status: 'fail');
    }
  } else {
    return Result(status: 'fail');
    // throw Exception('Failed to create Profiles.');
  }
}

class Profile {
  int id = 0;
  // ignore: non_constant_identifier_names
  String first_name = '';
  // ignore: non_constant_identifier_names
  String last_name = '';
  // ignore: non_constant_identifier_names
  String hash_name = '';
  String email = '';
  String mobile = '';
  // ignore: non_constant_identifier_names
  String country_code = '';
  String dob = '';
  // ignore: non_constant_identifier_names
  String first_run = '';
  String base64image = '';
  String password = '';
  String for64 = '';
  bool status = false;

  Profile({
    this.id = 0,
    // ignore: non_constant_identifier_names
    this.first_name = '',
    // ignore: non_constant_identifier_names
    this.last_name = '',
    // ignore: non_constant_identifier_names
    this.hash_name = '',
    this.email = '',
    this.mobile = '',
    // ignore: non_constant_identifier_names
    this.country_code = '',
    this.dob = '',
    // ignore: non_constant_identifier_names
    this.first_run = '',
    this.base64image = '',
    this.password = '',
    this.for64 = '',
    this.status = false,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: int.parse(json['id'] ?? '0'),
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
      hash_name: json['hash_name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      country_code: json['country_code'] ?? '',
      dob: json['dob'] ?? '',
      first_run: json['first_run'] ?? '',
      base64image: json['base64image'] ?? '',
      password: json['password'] ?? '',
      for64: json['for64'] ?? '',
      status: int.parse(json['status'] ?? '0') == 1,
    );
  }
}

class Profiles {
  String status = 'fail';
  List<Profile>? profiles;

  Profiles({required this.status, this.profiles});

  factory Profiles.fromJson(Map<String, dynamic> json) {
    return Profiles(
      status: json['status'] ?? 'fail',
      profiles: List<Profile>.from(
          json['profile'].map((item) => Profile.fromJson(item))),
    );
  }
}
