import 'package:shared_preferences/shared_preferences.dart';

class GlobalValues {
  static Future<void> setLastReceivedDocId(
      {required String collection, required String docId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(collection, docId);
  }

  static Future<String> getLastReceivedDocId(
      {required String collection}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(collection) ?? "";
  }
}
