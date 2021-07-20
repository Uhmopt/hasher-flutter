import 'package:hasher/actions/hasherAction.dart';
import 'package:hasher/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Hasher> initHasher({String email = ''}) async {
  return await SharedPreferences.getInstance().then((prefs) {
    return basicHasherInfo(email).then((hasher) {
      prefs.setInt(PREF_HASHER_ID, hasher.id);
      prefs.setString(PREF_HASHER_NAME, hasher.hashname);
      prefs.setString(PREF_HASHER_AVATAR, hasher.base64image);
      prefs.setString(PREF_EMAIL, hasher.email);

      return hasher;
    });
  });
}
