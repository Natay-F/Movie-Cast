part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  HomeState();

  // @override
  // List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class DirectorsLoading extends HomeState {}

class DirectorsLoaded extends HomeState {
  final List<Director> directors;

  DirectorsLoaded({this.directors = const []});
}

class DirectorSelected extends HomeState {
  final String directorId;

  DirectorSelected({required this.directorId});
}
