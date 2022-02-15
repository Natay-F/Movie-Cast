import 'package:flutter/material.dart';
import 'package:movie_cast_stacked/ui/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import './roster_view_model.dart';

class RosterView extends StatelessWidget {
  const RosterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RosterViewModel>.reactive(
      viewModelBuilder: () => RosterViewModel(),
      onModelReady: (RosterViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        RosterViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text("Roster"),
              actions: [
                TextButton(
                  child: Text(
                    "Actors / Actresses",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.blue,
                    ),
                  ),
                  onPressed: model.gotoPersonnelView,
                )
              ],
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 18.0),
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
                  if (model.personnelInRoster.isEmpty)
                    FutureBuilder(
                      future: Future.delayed(
                          Duration(
                            seconds: 1,
                          ),
                          () => "data"),
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return Center(
                              child: Text(
                            "No Actors or Actresses hired yet",
                            style: Theme.of(context).textTheme.headline6,
                          ));
                        else {
                          return CircularProgressIndicator.adaptive();
                        }
                      },
                    ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight:
                            screenHeightFraction(context, multipliedBy: 0.76)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.personnelInRoster.length,
                        itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () => model.isBusy
                                        ? null
                                        : model.removePersonnelFromRoster(model
                                            .personnelInRoster[index]
                                            .documentId),
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.remove_circle_outline,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    model.personnelInRoster[index].name,
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
                                    model.currency
                                        .format(
                                            model.personnelInRoster[index].cost)
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
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Text(
                        "Total",
                        style:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Text(model.totalCost()),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
