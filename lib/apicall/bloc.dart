import 'package:rgc_admin/apicall/modal.dart';
import 'package:rgc_admin/apicall/repo.dart';

import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final HomeRepo _homeRepo = HomeRepo();
  final BehaviorSubject<GuestReqListModal> _liveSlider =
      BehaviorSubject<GuestReqListModal>();
  BehaviorSubject<GuestReqListModal> get getGuestReqListModal => _liveSlider;
  fetchGestReq() async {
    try {
      GuestReqListModal homeSlider = await _homeRepo.fetchGuestReqListModal();
      // print(homeSlider.imgs!.length);

      _liveSlider.add(homeSlider);
    } catch (e) {
      //  print(e);
    }
  }

  final BehaviorSubject<GuestDetailModal> _liveData =
      BehaviorSubject<GuestDetailModal>();
  BehaviorSubject<GuestDetailModal> get getLiveDeatils => _liveData;
  fetchGuestDetails(id) async {
    try {
      _liveData.addError("error");
      GuestDetailModal homeSlider = await _homeRepo.fetchGuestDetails(id);
      // print(homeSlider.imgs!.length);

      _liveData.add(homeSlider);
    } catch (e) {
      //  print(e);
    }
  }
}

final homeBloc = HomeBloc();
