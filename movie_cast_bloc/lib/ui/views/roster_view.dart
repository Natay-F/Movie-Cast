import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_cast_bloc/blocs/home/home_bloc.dart';
import 'package:movie_cast_bloc/models/personnel.dart';
import 'package:movie_cast_bloc/services/firebase.dart';
import 'package:movie_cast_bloc/ui/shared/ui_helpers.dart';
import 'package:movie_cast_bloc/ui/views/personnel_view.dart';

class RosterView extends StatefulWidget {
  RosterView({Key? key}) : super(key: key);

  @override
  State<RosterView> createState() => _RosterViewState();
}

class _RosterViewState extends State<RosterView> {
  NumberFormat currency = NumberFormat.simpleCurrency();

  List<Personnel> personnelInRoster = [];

  @override
  Widget build(BuildContext context) {
    FirebaseService _firebaseService = FirebaseService();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Roster"),
          actions: [
            TextButton(
              child: Text(
                "Actors / Actresses",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    decoration: TextDecoration.underline, color: Colors.blue),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blue,
                ),
              ),
              onPressed: () => gotoPersonnelView(context),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 18.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Text(
                      "Name",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      "Cost",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              FutureBuilder(
                future: getRoster(context, personnelInRoster, _firebaseService),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    personnelInRoster = snapshot.data as List<Personnel>;
                    if (personnelInRoster.isNotEmpty) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: screenHeightFraction(context,
                                multipliedBy: 0.76)),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: personnelInRoster.length,
                            itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () => false
                                            ? null
                                            : removePersonnelFromRoster(
                                                context,
                                                personnelInRoster[index]
                                                    .documentId,
                                                personnelInRoster,
                                                _firebaseService,
                                              ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.remove_circle_outline,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        personnelInRoster[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                      ),
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text(
                                        currency
                                            .format(
                                                personnelInRoster[index].cost)
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                )),
                      );
                    } else {
                      return Center(
                          child: Text(
                        "No Actors or Actresses hired yet",
                        style: Theme.of(context).textTheme.headline6,
                      ));
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Text(
                    "Total",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Text(totalCost(personnelInRoster)),
                ],
              ),
            ],
          ),
        ));
  }

  void gotoPersonnelView(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PersonnelView(),
        ));
  }

  String totalCost(_personnelInRoster) {
    double totalCost = 0;
    _personnelInRoster.forEach((element) {
      totalCost += element.cost;
    });
    return currency.format(totalCost).toString();
  }

  removePersonnelFromRoster(
      context, String? documentId, _personnelInRoster, _firebaseService) async {
    String directorId = await BlocProvider.of<HomeBloc>(context).directorId;
    await FirebaseService().removePeronnelfromRoster(
        documentId!, await BlocProvider.of<HomeBloc>(context).directorId);
    await getRoster(
      context,
      _personnelInRoster,
      _firebaseService,
    );
    setState(() {});
  }

  getRoster(BuildContext context, List<Personnel> _personnelInRoster,
      FirebaseService _firebaseService) async {
    _personnelInRoster = [];
    String directorId = await BlocProvider.of<HomeBloc>(context).directorId;
    var data = await FirebaseService().getRoster(directorId);
    if (data is List) {
      for (var element in data) {
        _personnelInRoster.add(element);
      }
    }
    return _personnelInRoster;
  }
}
