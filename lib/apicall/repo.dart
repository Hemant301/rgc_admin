import 'dart:convert';

import 'package:rgc_admin/apicall/api.dart';
import 'package:rgc_admin/apicall/modal.dart';

class HomeRepo {
  HomeApi homeApi = HomeApi();
  Future<GuestReqListModal> fetchGuestReqListModal() async {
    final response = await homeApi.fetchHomeSlider();
    var jsonResponse = jsonDecode(response.body) as Map;
    return GuestReqListModal(jsonResponse);
  }

  Future<GuestDetailModal> fetchGuestDetails(id, context) async {
    final response = await homeApi.fetchGuestDetails(id, context);
    var jsonResponse = jsonDecode(response.body) as List;
    return GuestDetailModal(jsonResponse);
  }
}
