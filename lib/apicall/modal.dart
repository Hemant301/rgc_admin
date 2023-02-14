class GuestReqListModal {
  List<GuestListModal> list = [];
  GuestReqListModal(js) {
    for (var i = 0; i < js['newList'].length; i++) {
      list.add(GuestListModal(js['newList'][i]));
    }
  }
}

class GuestListModal {
  dynamic id;
  dynamic name;
  dynamic phone;
  dynamic guestNumber;
  GuestListModal(js) {
    id = js['guest_id'] ?? "";
    name = js['user_name'] ?? "";
    phone = js['user_phone'] ?? "";
    guestNumber = js['guest_no'] ?? "";
  }
}

class GuestDetailModal {
  List<GuestDetailListModal> list = [];
  GuestDetailModal(js) {
    for (var i = 0; i < js.length; i++) {
      list.add(GuestDetailListModal(js[i]));
    }
  }
}

class GuestDetailListModal {
  String? date;
  String? time;
  List<GuestUserListModal> user = [];
  GuestDetailListModal(js) {
    date = js['pick_date'] ?? "";
    time = js['pick_time'] ?? "";
    for (var i = 0; i < js['guestList'].length; i++) {
      user.add(GuestUserListModal(js['guestList'][i]));
    }
  }
}

class GuestUserListModal {
  dynamic id;
  dynamic name;
  dynamic phone;
  dynamic reason;
  dynamic approvedBy;
  dynamic status;
  GuestUserListModal(js) {
    id = js['_id'] ?? "";
    name = js['guest_name'] ?? "";
    phone = js['guest_phone'] ?? "";
    reason = js['reason'] ?? "";
    approvedBy = js['approved_by'] ?? "";
    status = js['status'] ?? "";
  }
}
