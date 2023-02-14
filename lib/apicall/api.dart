import 'dart:convert';
import 'dart:developer';

import 'package:fl_toast/fl_toast.dart';
import 'package:http/http.dart' as http;
import 'package:rgc_admin/apicall/bloc.dart';

class HomeApi {
  var client = http.Client();
  Future<dynamic> fetchHomeSlider() async {
    try {
      final response = await client.get(Uri.parse(
          "https://plankton-app-scdik.ondigitalocean.app/e846ed/api/guestapproval/guestmembers"));
      if (response.statusCode == 200) {
        log(response.body);
        return response;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<dynamic> fetchGuestDetails(id) async {
    try {
      final response = await client.post(
          Uri.parse(
              "https://plankton-app-scdik.ondigitalocean.app/e846ed/api/guestapproval/list"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'user_id': id}));
      if (response.statusCode == 200) {
        log(response.body);
        return response;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<dynamic> updateStatus(context,
      {String guestId = "", String status = "", String reason = ""}) async {
    var client = http.Client();
    try {
      // print(accid);
      // print(otp);
      final response = await client.post(
          Uri.parse(
              "https://plankton-app-scdik.ondigitalocean.app/e846ed/api/guestapproval/update/$guestId"),
          body: {"status": status, "reason": reason});
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body) as Map;
        await showTextToast(text: data['message'], context: context);
      
        return jsonDecode(response.body) as Map;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw "Something went wrong";
      }
    } catch (e) {
      print(e);
      throw "Something went wrong";
    } finally {
      client.close();
    }
  }
}

final homeApi = HomeApi();
