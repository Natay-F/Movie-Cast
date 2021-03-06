import 'package:movie_cast_stacked/app/app.locator.dart';
import 'package:movie_cast_stacked/app/app.router.dart';
import 'package:movie_cast_stacked/app/core/custom_base_view_model.dart';
import 'package:movie_cast_stacked/models/director.dart';
import 'package:movie_cast_stacked/services/director.dart';
import 'package:movie_cast_stacked/services/firebase.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends CustomBaseViewModel {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final DirectorService _directorService = locator<DirectorService>();
  final NavigationService _navigationService = locator<NavigationService>();
  List<Director> directorsList = [];

  Future<void> init() async {}

  getDirectors() async {
    List<Director> newdirectorsList = await _firebaseService.getDirector();
    if (newdirectorsList != null && newdirectorsList.isNotEmpty) {
      directorsList = newdirectorsList;
    }
    return directorsList;
  }

  onTap(String directorsId) {
    _directorService.setDirectorId = directorsId;
    _navigationService.replaceWith(Routes.personnelListView);
  }
}
