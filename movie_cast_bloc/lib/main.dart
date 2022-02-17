import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cast_bloc/blocs/home/home_bloc.dart';
import 'package:movie_cast_bloc/ui/views/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MovieCastBlocApp());
}

class MovieCastBlocApp extends StatelessWidget {
  const MovieCastBlocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()..add(LoadDirectors()),
          child: Container(),
        )
      ],
      child: MaterialApp(
        home: HomeView(),
        title: 'Movie Cast',
        theme: ThemeData(
          secondaryHeaderColor: Colors.amber,
          primaryColor: Colors.white,
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
