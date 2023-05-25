import 'dart:convert';

import 'package:dagather_frontend/models/user_model.dart';
import 'package:dagather_frontend/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String profile = "profile";
  static const String list = "list";
  static const String filter = 'filter';
  static const String image = 'image';

  static Future<List<UserModel>> getUsers({String? option}) async {
    late Uri url;
    Map<String, String> headers = {
      'Authorization': FirebaseAuth.instance.currentUser!.uid,
    };

    if (option != null) {
      final Map<String, String> queryParameters = {};
      queryParameters['filter'] = option;

      url = Uri.http(
        API.baseUrl,
        '${API.version}/$profile/$list',
        queryParameters,
      );
    } else {
      url = Uri.parse(
          'http://${API.baseUrl}${API.version}/$profile/$list?$filter=');
    }

    List<UserModel> userInstances = [];

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      if (body["data"] != null) {
        for (var user in body["data"]) {
          userInstances.add(UserModel.fromJson(user));
        }
      }
      return userInstances;
    }

    throw Error();
  }

  static Future<UserModel> getUserById(profileId) async {
    final url =
        Uri.parse('http://${API.baseUrl}${API.version}/$profile/$profileId');

    Map<String, String> headers = {
      'Authorization': FirebaseAuth.instance.currentUser!.uid,
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));

      final userModel = UserModel.fromJson(body["data"]);
      return userModel;
    }

    throw Error();
  }

  static Future<bool> hasDoneTutorial(profileId) async {
    final url =
        Uri.parse('http://${API.baseUrl}${API.version}/$profile/$profileId');

    Map<String, String> headers = {
      'Authorization': FirebaseAuth.instance.currentUser!.uid,
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      return false;
    }
    throw Error();
  }

  static Future<void> putUser(UserModel user) async {
    final url = Uri.parse('http://${API.baseUrl}${API.version}/$profile');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.put(
      url,
      headers: headers,
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      return;
    }

    throw Error();
  }

  static Future<String> getImageUrlBy(String imgUrl) async {
    final url =
        Uri.parse('http://${API.baseUrl}${API.version}/$profile/$image');

    final request = http.MultipartRequest("POST", url)
      ..files.add(await http.MultipartFile.fromPath('image', imgUrl));

    final streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      final response = await http.Response.fromStream(streamedResponse);
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));

      return body["data"]["imageUrl"];
    }
    throw Error();
  }
}
