import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../helper/localStorage/preference_handler.dart';

class UpdatedNetworkRequest {
  static const Map<String, dynamic> errorResp = {
    "status": false,
    "msg": "Unable to communicate with server",
    "data": null
  };

  /// 🔥 COMMON API HANDLER (GET, POST, PUT, DELETE)
  Future<Map<String, dynamic>> request({
    required String url,
    String method = "GET",
    Map<String, dynamic>? body,
    bool tokenRequired = false,
  }) async {
    try {
      final headers = await _getHeaders(tokenRequired);

      http.Response response;
      print("Request API URL: ${url}");
      print("Request API: ${body}");
      print("Header Request: ${headers}");

      switch (method) {
        case "POST":
          response = await http.post(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(body ?? {}),
          );
          break;

        case "PUT":
          response = await http.put(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(body ?? {}),
          );
          break;

        case "DELETE":
          response = await http.delete(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(body ?? {}),
          );
          break;

        default:
          response = await http.get(
            Uri.parse(url),
            headers: headers,
          );
      }

      print("API Status Code: ${response.statusCode}");
      print("API Body: ${response.body}");

      return _handleResponse(response);
    } on SocketException {
      return {
        "status": false,
        "msg": "No Internet Connection",
      };
    } catch (e) {
      return {
        "status": false,
        "msg": e.toString(),
      };
    }
  }

  /// 🔐 HEADERS
  Future<Map<String, String>> _getHeaders(bool tokenRequired) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    if (tokenRequired) {
      final token = await PreferenceHandler.getLoginToken();
      headers["Authorization"] = "Bearer $token";
    }

    return headers;
  }

  /// 📦 RESPONSE HANDLER
  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    try {
      final data = jsonDecode(response.body);

      if (statusCode >= 200 && statusCode < 300) {
        return data;
      } else if (statusCode == 401) {
        return {
          "status": false,
          "msg": "Session expired",
          "code": 401,
        };
      } else {
        return {
          "status": false,
          "msg": data["message"] ?? "Something went wrong",
          "code": statusCode,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "msg": "Invalid response format",
        "code": statusCode,
      };
    }
  }

  /// 📤 FILE UPLOAD
  Future<Map<String, dynamic>> uploadFile({
    required String url,
    required String filePath,
    bool tokenRequired = true,
  }) async {
    try {
      final uri = Uri.parse(url);
      final request = http.MultipartRequest("POST", uri);

      if (tokenRequired) {
        final token = await PreferenceHandler.getLoginToken();
        request.headers["Authorization"] = "Bearer $token";
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          filePath,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        return {
          "status": false,
          "msg": "Upload failed",
          "code": response.statusCode,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "msg": e.toString(),
      };
    }
  }

  /// 📤 MULTIPART POST WITH IMAGE
  Future<Map<String, dynamic>> postWithImage({
    required String url,
    required String imagePath,
    bool tokenRequired = false,
  }) async {
    try {
      final uri = Uri.parse(url);
      final request = http.MultipartRequest("POST", uri);

      if (tokenRequired) {
        final token = await PreferenceHandler.getLoginToken();
        request.headers["Authorization"] = "Bearer $token";
      }

      request.files.add(
        await http.MultipartFile.fromPath('file', imagePath),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        return {
          "status": false,
          "msg": "Request failed",
          "code": response.statusCode,
        };
      }
    } on SocketException {
      return {
        "status": false,
        "msg": "No Internet Connection",
      };
    } catch (e) {
      return {
        "status": false,
        "msg": e.toString(),
      };
    }
  }
}


// Calling.....

// final api = NetworkRequest();
//
// // GET
// var res = await api.request(url: "your_url");
//
// // POST
// var res = await api.request(
// url: "your_url",
// method: "POST",
// body: {"name": "Gaurav"},
// );
//
// // PUT
// var res = await api.request(
// url: "your_url",
// method: "PUT",
// body: {"name": "Updated"},
// );
//
// // DELETE
// var res = await api.request(
// url: "your_url",
// method: "DELETE",
// );
//
// // Upload
// var res = await api.uploadFile(
// url: "your_url",
// filePath: imagePath,
// );