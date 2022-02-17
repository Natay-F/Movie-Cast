import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_cast_bloc/models/director.dart';
import 'package:movie_cast_bloc/services/firebase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String? _directorId;

  final _directorIdStateController = StreamController<String>();
  Sink<String> get _inId => _directorIdStateController.sink;
  String get directorId => _directorId ?? "";

  HomeBloc() : super(DirectorsLoading()) {
    on<LoadDirectors>(_onLoadDirectors);
    on<SelectDirector>(_onSelectDirector);
  }

  Future<void> _onLoadDirectors(
      LoadDirectors event, Emitter<HomeState> emit) async {
    var result = await FirebaseService().getDirectors();
    if (result is List) {
      List<Director> directors = result as List<Director>;
      emit(DirectorsLoaded(directors: directors));
    }
  }

  FutureOr<void> _onSelectDirector(
      SelectDirector event, Emitter<HomeState> emit) {
    _inId.add(event.directorId);
    _directorId = event.directorId;
  }
}
