import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../shared/ui_helpers.dart';
import '../../widgets/personnel_card.dart';
import './personnel_list_view_model.dart';

class PersonnelListView extends StatelessWidget {
  const PersonnelListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonnelListViewModel>.reactive(
      viewModelBuilder: () => PersonnelListViewModel(),
      onModelReady: (PersonnelListViewModel model) async {
        await model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text("Actors / Actresses"),
              actions: [
                TextButton(
                  child: Text(
                    "Roster",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.blue,
                    ),
                  ),
                  onPressed: model.gotoRosterView,
                )
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: ElevatedButton(
              child: Text(
                "New Actor / Actress",
                style: Theme.of(context).textTheme.headline5!,
              ),
              onPressed: model.gotoNewPersonnelView,
              style: ButtonStyle(
                  elevation: MaterialStateProperty.resolveWith((states) => 10),
                  fixedSize: MaterialStateProperty.resolveWith(
                    (states) => Size(
                        screenWidthFraction(context, multipliedBy: 0.8),
                        screenHeightFraction(context, multipliedBy: 0.08)),
                  )),
            ),
            body: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight:
                          screenHeightFraction(context, multipliedBy: 0.76)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.personnels.length,
                    itemBuilder: (context, index) => PersonnelCard(
                      addToRoster: () => model.isBusy
                          ? null
                          : model
                              .addToRoster(model.personnels[index].documentId!),
                      cost: model.personnels[index].cost,
                      description: model.personnels[index].description,
                      name: model.personnels[index].name,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeightFraction(
                    context,
                    multipliedBy: 0.088,
                  ),
                )
              ],
            ));
      },
    );
  }
}
