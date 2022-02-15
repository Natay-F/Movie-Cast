// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/views/home/home_view.dart';
import '../ui/views/new_personnel/new_personnel_view.dart';
import '../ui/views/personnel_list/personnel_list_view.dart';
import '../ui/views/roster/roster_view.dart';

class Routes {
  static const String homeView = '/';
  static const String personnelListView = '/personnel-list-view';
  static const String rosterView = '/roster-view';
  static const String newPersonnelView = '/new-personnel-view';
  static const all = <String>{
    homeView,
    personnelListView,
    rosterView,
    newPersonnelView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.personnelListView, page: PersonnelListView),
    RouteDef(Routes.rosterView, page: RosterView),
    RouteDef(Routes.newPersonnelView, page: NewPersonnelView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    PersonnelListView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const PersonnelListView(),
        settings: data,
      );
    },
    RosterView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const RosterView(),
        settings: data,
      );
    },
    NewPersonnelView: (data) {
      var args = data.getArgs<NewPersonnelViewArguments>(
        orElse: () => NewPersonnelViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => NewPersonnelView(key: args.key),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// NewPersonnelView arguments holder class
class NewPersonnelViewArguments {
  final Key? key;
  NewPersonnelViewArguments({this.key});
}
