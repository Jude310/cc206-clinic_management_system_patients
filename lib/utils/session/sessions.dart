import 'package:http/http.dart' as http;

class Session {
  static Map<String, String> headers = {};
  static void clearSession() {
    headers = {};
  }
  
  static String url = '10.0.2.2:3000';
  // Private constructor to prevent external instantiation
  Session._privateConstructor();

  // Singleton instance
  static final Session _instance = Session._privateConstructor();

  // Getter to access the singleton instance
  static Session get instance => _instance;

  static Future get(String path) async {
    Uri httpUrl = Uri.http(url, path);
    var response = await http.get(httpUrl, headers: headers);
    _updateCookie(response);
    return response;
  }

  static Future post(String path, {dynamic body}) async {
    Uri httpUrl = Uri.http(url, path);
    var response = await http.post(httpUrl, body: body, headers: headers);
    _updateCookie(response);
    return response;
  }

  static void _updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
