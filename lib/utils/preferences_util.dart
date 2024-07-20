import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {

  static const String remoteCtrlIp = "remoteCtrlIp";
  static const String remoteCtrlPort = "remoteCtrlPort";
  static const String remoteUsername = "remoteUsername";
  static const String remoteUserPwd = "remoteUserPwd";
  static const String remoteComMac = "remoteComMac";//远程电脑物理地址

  static final PreferencesUtil _instance = PreferencesUtil._internal();

  factory PreferencesUtil() => _instance;

  PreferencesUtil._internal() : prefs = null; // 初始化prefs为null

  SharedPreferences? prefs; // 将prefs类型改为可空

  Future<void> init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveBool(String key, bool value) async {
    await init();
    await prefs!.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    await init();
    return prefs!.getBool(key) ?? false;
  }

  Future<void> saveInt(String key, int value) async {
    await init();
    await prefs!.setInt(key, value);
  }

  Future<int> getInt(String key) async {
    await init();
    return prefs!.getInt(key) ?? 0;
  }

  Future<void> saveString(String key, String value) async {
    await init();
    await prefs!.setString(key, value);
  }

  Future<String> getStringWithDefault(String key, String defaultValue) async {
    await init();
    return prefs!.getString(key) ?? defaultValue;
  }

  Future<String> getString(String key) async {
    await init();
    return prefs!.getString(key) ?? "";
  }

  Future<void> saveDouble(String key, double value) async {
    await init();
    await prefs!.setDouble(key, value);
  }

  Future<double> getDouble(String key) async {
    await init();
    return prefs!.getDouble(key) ?? 0;
  }

  Future<void> saveStringList(String key, List<String> values) async {
    await init();
    prefs!.setStringList(key, values);
  }

  Future<List<String>?> getStringList(String key) async {
    await init();
    return prefs!.getStringList(key);
  }
}