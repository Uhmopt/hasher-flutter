import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:hasher/actions/profileAction.dart';
import 'package:hasher/config.dart';
import 'package:hasher/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  log('login: ' + response.body);
  if (response.statusCode == 200) {
    return getProfiles(email).then((profiles) {
      if (profiles.profiles!.length == 1) {
        return SharedPreferences.getInstance().then((prefs) {
          // set preference
          prefs.clear();
          prefs.setInt(PREF_HASHER_ID, profiles.profiles![0].id);
          prefs.setString(
              PREF_HASHER_FIRST_NAME, profiles.profiles![0].first_name);
          prefs.setString(
              PREF_HASHER_LAST_NAME, profiles.profiles![0].last_name);
          prefs.setString(PREF_HASHER_NAME, profiles.profiles![0].hash_name);
          prefs.setString(PREF_EMAIL, profiles.profiles![0].email);
          prefs.setString(PREF_HASHER_PHONE, profiles.profiles![0].mobile);
          prefs.setString(
              PREF_HASHER_COUNTRY_CODE, profiles.profiles![0].country_code);
          prefs.setString(PREF_HASHER_BIRTH, profiles.profiles![0].dob);
          prefs.setString(
              PREF_HASHER_FIRST_RUN, profiles.profiles![0].first_run);
          prefs.setString(
              PREF_HASHER_AVATAR, profiles.profiles![0].base64image);
          prefs.setBool(PREF_HASHER_STATUS, profiles.profiles![0].status);

          try {
            return new Result.fromJson(jsonDecode(response.body));
          } catch (e) {
            return new Result(status: 'fail');
          }
        });
      } else {
        return new Result(status: 'fail');
      }
    });
  } else {
    throw Exception('Failed Network.');
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
      return new Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new Result(status: 'fail');
    }
  } else {
    return new Result(status: 'fail');
    // throw Exception('Failed to create Result.');
  }
}

Future<Result> updateProfileAction(
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
      return new Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new Result(status: 'fail');
    }
  } else {
    return new Result(status: 'fail');
    // throw Exception('Failed to create Result.');
  }
}

Future<Result> forgotAction(String email) async {
  Map<String, String> headers = {
    "content-type": "application/x-www-form-urlencoded; charset=utf-8"
  };

  var data = new Map<String, String>();
  data['email'] = email;

  final response = await http.post(
    Uri.parse(apiBase + '/forgot_mo.php'),
    headers: headers,
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );
  log(response.body);
  if (response.statusCode == 200) {
    try {
      return new Result.fromJson(jsonDecode(response.body));
    } catch (e) {
      return new Result(status: 'fail');
    }
  } else {
    return new Result(status: 'fail');
    // throw Exception('Failed to create Result.');
  }
}

class Result {
  final String status;

  Result({required this.status});

  factory Result.fromJson(Map<String, dynamic> json) {
    return new Result(
      status: json['status'],
    );
  }
}
