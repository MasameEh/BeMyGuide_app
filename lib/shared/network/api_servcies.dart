
import 'dart:convert';

import 'package:graduation_project/shared/network/endpoints.dart';
import 'package:http/http.dart' as http;



class ApiServices {
  static String baseUrl = "https://api.openai.com/v1/completions";
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey1',
  };

  static Future<String?> sendMessage(String msg) async {
    try {
      var res = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: json.encode({
          "model": "text-davinci-003",
          "prompt": msg,
          "temperature": 0,
          "max_tokens": 200,
          "top_p": 1,
        }),
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        var message = data['choices'][0]['text'];
        print(message);
        return message;
      } else {
        print("API request failed with status code: ${res.statusCode}");
        return null;
      }
    } catch (e) {
      print("An error occurred during API request: $e");
      return null;
    }
  }
}



