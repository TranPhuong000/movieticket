import 'dart:convert';
import 'package:http/http.dart' as http;

//thực hiện các yêu cầu HTTP GET và POST.
class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<dynamic> getRequest(
      String endpoint, Map<String, String> headers) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print('data sau khi call api : $responseData');
      return responseData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> postRequest(String endpoint, Map<String, String> headers,
      Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print('data sau khi call api : $responseData');
      return responseData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
