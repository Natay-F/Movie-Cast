import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cast_bloc/blocs/home/home_bloc.dart';
import 'package:movie_cast_bloc/models/personnel.dart';
import 'package:movie_cast_bloc/services/firebase.dart';
import 'package:movie_cast_bloc/ui/shared/ui_helpers.dart';
import 'package:movie_cast_bloc/ui/views/new_personnel_view.dart';
import 'package:movie_cast_bloc/ui/views/roster_view.dart';
import 'package:movie_cast_bloc/ui/widgets/personnel_card.dart';

class PersonnelView extends StatelessWidget {
  const PersonnelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _firebaseService = FirebaseService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Actors / Actresses"),
        actions: [
          TextButton(
            child: Text(
              "Roster",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  decoration: TextDecoration.underline, color: Colors.blue),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.blue,
              ),
            ),
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RosterView(),
                )),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        child: Text(
          "New Actor / Actress",
          style: Theme.of(context).textTheme.headline5!,
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPersonnelView(),
            )),
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 10),
            fixedSize: MaterialStateProperty.resolveWith(
              (states) => Size(screenWidthFraction(context, multipliedBy: 0.8),
                  screenHeightFraction(context, multipliedBy: 0.08)),
            )),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: _firebaseService.listenToPersonnel(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Personnel> personnelList =
                    snapshot.data as List<Personnel>;
                return ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight:
                          screenHeightFraction(context, multipliedBy: 0.76)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: personnelList.length,
                    itemBuilder: (context, index) => PersonnelCard(
                      addToRoster: () async => await
                          //  => model.isBusy
                          //     ? null
                          addToRoster(context, personnelList[index].documentId!,
                              _firebaseService),
                      cost: personnelList[index].cost,
                      description: personnelList[index].description,
                      name: personnelList[index].name,
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(
            height: screenHeightFraction(
              context,
              multipliedBy: 0.088,
            ),
          )
        ],
      ),
    );
  }

  Future<void> addToRoster(BuildContext context, String documentId,
      FirebaseService _firebaseService) async {
    await _firebaseService.addPeronneltoRoster(
        documentId, await BlocProvider.of<HomeBloc>(context).directorId);
  }
}
