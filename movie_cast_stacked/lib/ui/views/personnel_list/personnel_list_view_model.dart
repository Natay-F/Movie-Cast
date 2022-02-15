import 'package:movie_cast_stacked/app/app.locator.dart';
import 'package:movie_cast_stacked/app/app.router.dart';
import 'package:movie_cast_stacked/app/core/custom_base_view_model.dart';
import 'package:movie_cast_stacked/models/personnel.dart';
import 'package:movie_cast_stacked/services/director.dart';
import 'package:movie_cast_stacked/services/firebase.dart';
import 'package:stacked_services/stacked_services.dart';

class PersonnelListViewModel extends CustomBaseViewModel {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DirectorService _directorService = locator<DirectorService>();

  List<Personnel> _personnels = [];

  List<Personnel> get personnels => _personnels;

  Future<void> init() async {
    listenToPersonnels();
  }

  Future<void> listenToPersonnels() async {
    setBusy(true);
    _firebaseService.listenToPersonnel().listen((personnelData) {
      List<Personnel> updatedpersonnels = personnelData;

      if (updatedpersonnels != null && updatedpersonnels.isNotEmpty) {
        _personnels = updatedpersonnels;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  void gotoRosterView() {
    _navigationService.replaceWith(Routes.rosterView);
  }

  void gotoNewPersonnelView() {
    _navigationService.navigateTo(Routes.newPersonnelView);
  }

  Future<void> addToRoster(String documentId) async {
    await _firebaseService.addPeronneltoRoster(
        documentId, _directorService.directorId);
  }
}
