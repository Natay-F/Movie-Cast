import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_cast_bloc/blocs/home/home_bloc.dart';
import 'package:movie_cast_bloc/models/personnel.dart';
import 'package:movie_cast_bloc/services/firebase.dart';

part 'roster_event.dart';
part 'roster_state.dart';

class RosterBloc extends Bloc<RosterEvent, RosterState> {
  RosterBloc() : super(RosterInitial()) {
    on<LoadRoster>(_onLoadRoster);
  }

  Future<FutureOr<void>> _onLoadRoster(
      LoadRoster event, Emitter<RosterState> emit) async {
    List<Personnel> _personnelInRoster = [];

    /// Couldn't Find a way to access the [directorId] in HomeBloc

    // String directorId = BlocProvider.of<HomeBloc>(context).directorId;
    // var data = await FirebaseService().getRoster(directorId);
    // if (data is List) {
    //   for (var element in data) {
    //     _personnelInRoster.add(element);
    //   }
    // }

    emit(RosterLoaded(personnel: _personnelInRoster));
  }
}
