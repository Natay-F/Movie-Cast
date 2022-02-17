import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'personnel_event.dart';
part 'personnel_state.dart';

class PersonnelBloc extends Bloc<PersonnelEvent, PersonnelState> {
  PersonnelBloc() : super(PersonnelInitial()) {
    on<PersonnelEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
