import 'package:http/http.dart' as http;

class HttpHandlerUtil {

  static final HttpHandlerUtil _instance = HttpHandlerUtil._internal();

  factory HttpHandlerUtil() => _instance;

  HttpHandlerUtil._internal();

  Future<void> sendCommand(String strUrl) async {
    final response = await http.get(Uri.parse(strUrl));
    if(response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('发送命令到服务器失败');
    }
  }
}