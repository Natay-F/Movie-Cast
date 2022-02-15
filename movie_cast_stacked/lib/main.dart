import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_cast_stacked/ui/views/home/home_view.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'ui/views/personnel_list/personnel_list_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Firebase
  await Firebase.initializeApp();

  /// Sets logging level
  Logger.level = Level.debug;

  /// Register all the models and services before the app starts
  setupLocator();

  /// Runs the app :)
  runApp(MovieCastStackedApp());
}

class MovieCastStackedApp extends StatelessWidget {
  MovieCastStackedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
      title: 'Movie Cast',
      theme: ThemeData(
        secondaryHeaderColor: Colors.amber,
        primaryColor: Colors.white,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.compact,
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
