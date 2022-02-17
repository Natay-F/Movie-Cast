part of 'roster_bloc.dart';

@immutable
abstract class RosterEvent {}

class LoadRoster extends RosterEvent {
  final List<Personnel> personnel;

  LoadRoster({
    this.personnel = const <Personnel>[],
  });
}
