import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPreferences? pref;
  Future<void> initPref() async {
    pref = pref ?? await SharedPreferences.getInstance();
  }
  set contact(List<String> value) => pref?.setStringList("contact", value);
  List<String> get contact => pref?.getStringList("contact") ?? [];
  set contact2(List<String> value) => pref?.setStringList("contact2", value);
  List<String> get contact2 => pref?.getStringList("contact2") ?? [];
}

final sheredPref = SharedPref();
