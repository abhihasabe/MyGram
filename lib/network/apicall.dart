import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Constant.dart';

class APICall {
  static final APICall _apiCall = APICall._internal();

  factory APICall() {
    return _apiCall;
  }

  static Future<Map> postJsonData(String parameters, Map<String, dynamic> Json) async {
    print("$parameters, $Json");
    var responceJson;
    final String uri = Constant.baseURL + parameters;
    final String jsonBody = json.encode(Json);
    final encoding = Encoding.getByName('utf-8');
    final headers = {'Content-Type': 'application/json'};

    var response = await http.post(uri, headers: headers, body: jsonBody, encoding: encoding);
    print("statusCode ${response?.statusCode}");
    if (response.statusCode == 200) {
      var jsonResponce = json.decode(response.body);
      return jsonResponce;
    } else {
      responceJson = {
        "code": response.statusCode,
        "message": 'Unable to Reach Server',
        "responce": Null,
      };
      return responceJson;
    }
  }

  static Future getJsonData(String parameters, String input) async {

    var responceJson;

    final encoding = Encoding.getByName('utf-8');
    final String uri = parameters+input;
    final headers = {'Content-Type': 'application/json'};

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonObj = jsonDecode(response.body);
      return jsonObj;
    } else {
      responceJson = {
        "code": response.statusCode,
        "message": 'Unable to Reach Server',

        "responce": Null,
      };
      return responceJson;
    }
  }

  static Future getJsonData1(String parameters, String input) async {

    var responceJson;

    final encoding = Encoding.getByName('utf-8');
    final String uri = parameters+input;
    final headers = {'Content-Type': 'application/json'};

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonObj = jsonDecode(response.body);
      return jsonObj;
    } else {
      responceJson = {
        "code": response.statusCode,
        "message": 'Unable to Reach Server',

        "responce": Null,
      };
      return responceJson;
    }
  }



  APICall._internal();
}
