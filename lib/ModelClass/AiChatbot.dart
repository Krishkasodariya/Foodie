import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AiChatbot {
  static Future<Map<String, String>> getheader() async {
    return {
      "Content-Type": "application/json",
    };
  }

  Future<String> getGeminiData(promts,context) async {
    try {
      final header = await getheader();
      String apiKey = "AIzaSyAg-hzGNUNGlJr88aYbRE0jCB2FfUjN0WA";
      String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${apiKey}";

      final Map<String, dynamic> requestBody = {
        "contents": [
          {
            "parts": [
              {
                "text":
                    "Create a recipe from a list of ingredients : \n ${promts}",
              }
            ]
          }
        ],
        "generationConfig": {"temperature": 0.8, "maxOutputTokens": 1000}
      };

      final response = await http.post(Uri.parse(url),
          headers: header,
          body: jsonEncode(requestBody));
      print("---response------)${response.body}");

      if (response.statusCode == 200){
        final data = jsonDecode(response.body);
        final recipe = data['candidates'][0]['content']['parts'][0]['text'];
        print("---recipe------)${recipe}");
        return recipe;
      } else {
        return "";
      }
    } catch (e) {
      print('---error---)${e}');
      return '';
    }
  }
}
