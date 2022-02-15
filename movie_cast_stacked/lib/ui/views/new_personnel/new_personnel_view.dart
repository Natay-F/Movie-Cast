import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_cast_stacked/ui/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import './new_personnel_view_model.dart';
import 'new_personnel_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'name'),
  FormTextField(name: 'cost'),
  FormTextField(name: 'description'),
])
class NewPersonnelView extends StatelessWidget with $NewPersonnelView {
  NewPersonnelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewPersonnelViewModel>.reactive(
      viewModelBuilder: () => NewPersonnelViewModel(),
      onModelReady: (NewPersonnelViewModel model) async {
        listenToFormUpdated(model);
      },
      builder: (
        BuildContext context,
        NewPersonnelViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("New Actor/Actress"),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: costController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Cost",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: model.validationMessage != null
                    ? model.showValidation
                    : false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(model.validationMessage ?? ""),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: SelectedBorder(),
                  fixedSize: MaterialStateProperty.resolveWith(
                    (states) => Size(
                      screenWidthFraction(context, multipliedBy: 0.7),
                      screenHeightFraction(context, multipliedBy: 0.07),
                    ),
                  ),
                ),
                onPressed: model.submitNewPersonnel,
                child: Text(
                  "Submit",
                  style: Theme.of(context).textTheme.headline5!,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class SelectedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  @override
  OutlinedBorder? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
    }
    return null; // Defer to default value on the theme or widget.
  }
}
