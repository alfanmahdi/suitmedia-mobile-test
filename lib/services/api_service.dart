import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:suitmedia_test/models/user_model.dart';

Future<List<User>> fetchUsers({required int page}) async {
  final response = await http.get(
    Uri.parse('https://reqres.in/api/users?page=$page&per_page=10'),
  );

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    final List<dynamic> userListJson = body['data'];

    return userListJson.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
