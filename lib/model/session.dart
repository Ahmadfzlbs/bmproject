import 'package:shared_preferences/shared_preferences.dart';

class SessionSet {
  SessionSet._initConst();
  static final SessionSet instant = SessionSet._initConst();

  Future setSession(String key, String value) async {
    final shared = await SharedPreferences.getInstance();
     if(shared.containsKey(key)){
       shared.clear();
     }

     shared.setString(key, value);
  }

  Future getSession(String key) async {
    final shared = await SharedPreferences.getInstance();
    if(shared.containsKey(key)) {
      return shared;
    }

    return null;
  }

  Future logout() async {
    final shared = await SharedPreferences.getInstance();
    shared.clear();
  }
}