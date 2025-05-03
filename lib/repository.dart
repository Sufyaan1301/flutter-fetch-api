import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_fetch_api/model.dart';

class Repository {
  final _baseURL = 'https://67f7c6d22466325443eaab70.mockapi.io/mobiledatadumm';

  Future<List<Blog>> getdata() async {
    try {
      final response = await http.get(Uri.parse(_baseURL));

      if (response.statusCode == 200) {
        // print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Blog> blog = it.map((e) => Blog.fromJson(e)).toList();
        return blog;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future postdata(String nama, String pass, String email, String id) async {
    try {
      final response = await http.post(
        Uri.parse(_baseURL),
        body: {"nama": nama, "pass": pass, "email": email, "id": id},
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future putData(String id, String nama, String pass, String email) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseURL/$id'),
        body: {"nama": nama, "pass": pass, "email": email},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseURL/$id'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
