import 'dart:io';
import 'package:task/network/exceptions.dart';
import 'package:task/network/url.dart';
import 'package:task/model/employeeList.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkApi {
  Future<User> createUser(Map<String, dynamic> user) async {
    try {
      var response = await http.post(NetworkUrl.createURL, body: user);
      print(response.statusCode);
      if (response.statusCode == 429) throw Exception("Too many request");
      if (response.statusCode == 200) {
        var body = convert.jsonDecode(response.body);
        User userRes = User.fromJson(body);
        return userRes;
      }
      
    } on SocketException {
      throw Faliures.noInternet;
    } on HttpException {
      throw Faliures.httpError;
    } on FormatException {
      throw Faliures.invalidFormat;
    }
  }

  Future<EmployeeList> fetchEmployeeList() async {
    try {
      var response = await http.get(NetworkUrl.fetchEmployeeList);
      if (response.statusCode == 429) throw Exception("Too many request");
      if (response.statusCode == 200) {
        var body = convert.jsonDecode(response.body);
        var result = EmployeeList.fromJson(body);
        return result;
      }
    } on SocketException {
      throw Faliures.noInternet;
    } on HttpException {
      throw Faliures.httpError;
    } on FormatException {
      throw Faliures.invalidFormat;
    }
  }
}
