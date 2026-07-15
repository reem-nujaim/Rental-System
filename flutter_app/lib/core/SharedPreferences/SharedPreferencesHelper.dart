import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();
  SharedPreferences? _prefs;

  SharedPrefsHelper._internal();

  factory SharedPrefsHelper() {
    return _instance;
  }

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

// حفظ التوكن
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

// جلب التوكن
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id'); // أو أي قيمة من التوكن
  }

  Future<int?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user_id'); // تحقق من وجود user_id
  }

  // دالة لتخزين حالة تسجيل الدخول
  Future<void> setLoginStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

// دالة للتحقق من حالة تسجيل الدخول
  Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> verifyAccount() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_verified', true); // تحديث حالة التوثيق
  }

  //التوثيق
  Future<bool> getVerifiedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_verified') ?? false;
  }

  // دالة لحفظ userId في SharedPreferences
  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  // Save a string value
  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Future<int?> getUserId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt('user_id');
  // }

  // Get a string value
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Remove a key
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Clear all data
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
