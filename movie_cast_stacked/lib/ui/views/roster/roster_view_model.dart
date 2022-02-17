import 'package:movie_cast_stacked/app/app.locator.dart';
import 'package:movie_cast_stacked/app/app.router.dart';
import 'package:movie_cast_stacked/app/core/custom_base_view_model.dart';
import 'package:movie_cast_stacked/models/personnel.dart';
import 'package:movie_cast_stacked/services/director.dart';
import 'package:movie_cast_stacked/services/firebase.dart';

import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

class RosterViewModel extends CustomBaseViewModel {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DirectorService _directorService = locator<DirectorService>();

  List<Personnel> _personnelInRoster = [];
  List<Personnel> get personnelInRoster => _personnelInRoster;

  NumberFormat currency = NumberFormat.simpleCurrency();

  Future<void> init() async {
    getRoster();
  }

  void gotoPersonnelView() {
    _navigationService.replaceWith(Routes.personnelListView);
  }

  String totalCost() {
    double totalCost = 0;
    _personnelInRoster.forEach((element) {
      totalCost += element.cost;
    });
    return currency.format(totalCost).toString();
  }

  removePersonnelFromRoster(String? documentId) async {
    setBusy(true);
    await _firebaseService.removePeronnelfromRoster(
        documentId!, _directorService.directorId);
    await getRoster();
    setBusy(false);
  }

  Future<void> getRoster() async {
    setBusy(true);
    _personnelInRoster = [];
    print(_directorService.directorId);
    var data = await _firebaseService.getRoster(_directorService.directorId);
    if (data is List) {
      for (var element in data) {
        _personnelInRoster.add(element);
      }
      notifyListeners();
    }
    setBusy(false);
  }
}
