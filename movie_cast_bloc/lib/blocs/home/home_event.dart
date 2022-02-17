part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class LoadDirectors extends HomeEvent {
  final List<Director> directors;

  LoadDirectors({
    this.directors = const <Director>[],
  });
}

class SelectDirector extends HomeEvent {
  final String directorId;

  SelectDirector({required this.directorId});
}
