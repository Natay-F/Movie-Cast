import 'package:movie_cast_stacked/services/director.dart';
import 'package:movie_cast_stacked/services/firebase.dart';
import 'package:movie_cast_stacked/ui/views/home/home_view.dart';
import 'package:movie_cast_stacked/ui/views/new_personnel/new_personnel_view.dart';
import 'package:movie_cast_stacked/ui/views/personnel_list/personnel_list_view.dart';
import 'package:movie_cast_stacked/ui/views/roster/roster_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomeView, initial: true),
  CupertinoRoute(page: PersonnelListView),
  CupertinoRoute(page: RosterView),
  CupertinoRoute(page: NewPersonnelView),
], dependencies: [
  // Stacked Services
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: FirebaseService),
  LazySingleton(classType: DirectorService)
])
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
