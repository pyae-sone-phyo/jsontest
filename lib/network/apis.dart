import 'package:http/http.dart' as http;
import 'dart:async';

class Api {
  static const base_url = "https://jsonplaceholder.typicode.com/posts/1";

  static Future<http.Response> fetchPost() {
    final response = http.get(base_url);
    return response;
  }
}
