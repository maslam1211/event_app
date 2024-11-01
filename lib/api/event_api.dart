
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<bool> signUpForEvent(String name, String email) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode({
          'name': name,
          'email': email,
        }),
      );
      return response.statusCode == 201;
    } catch (error) {
      print("Error signing up: $error");
      return false;
    }
  }
}
