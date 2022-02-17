part of 'roster_bloc.dart';

@immutable
abstract class RosterState {}

class RosterInitial extends RosterState {}

class RosterLoading extends RosterState {}

class RosterLoaded extends RosterState {
  final List<Personnel> personnel;

  RosterLoaded({this.personnel = const []});
}
