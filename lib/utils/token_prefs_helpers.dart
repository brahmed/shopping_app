import 'package:shared_preferences/shared_preferences.dart';

/// Prefs user token key
const String prefUserTokenKey = 'token';

/// Save user token when logged in
void saveUserToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(prefUserTokenKey, token);
}

/// Get user token
Future<String?> getUserToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(prefUserTokenKey);
}

/// Delete user token
void deleteUserToken() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(prefUserTokenKey);
}