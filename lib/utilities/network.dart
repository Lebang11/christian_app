import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Network {
  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        print("response from URL: ${response.body}");
        return response.body;
      }
    } catch (e) {
      print("Error fetching URL: ${e}");
      debugPrint(e.toString());
    }
    return null;
  }
}
