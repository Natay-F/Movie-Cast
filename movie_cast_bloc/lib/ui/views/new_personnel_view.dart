import 'package:flutter/material.dart';
import 'package:movie_cast_bloc/models/personnel.dart';
import 'package:movie_cast_bloc/services/firebase.dart';
import 'package:movie_cast_bloc/ui/shared/ui_helpers.dart';

class NewPersonnelView extends StatefulWidget {
  NewPersonnelView({Key? key}) : super(key: key);

  @override
  State<NewPersonnelView> createState() => _NewPersonnelViewState();
}

class _NewPersonnelViewState extends State<NewPersonnelView> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController costController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  bool showValidation = false;

  String? validationMessage;

  @override
  Widget build(BuildContext context) {
    FirebaseService _firebaseService = FirebaseService();

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
            visible: validationMessage != null ? showValidation : false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(validationMessage ?? ""),
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
            onPressed: () => submitNewPersonnel(context, _firebaseService),
            child: Text(
              "Submit",
              style: Theme.of(context).textTheme.headline5!,
            ),
          )
        ],
      ),
    );
  }

  void setValidationMessage(String? value) {
    validationMessage = value;
    showValidation = validationMessage?.isNotEmpty ?? false;
    setState(() {});
  }

  Future<void> submitNewPersonnel(
    BuildContext context,
    FirebaseService _firebaseService,
  ) async {
    // setBusy(true);
    if (validateData()) {
      await _firebaseService.addPersonnel(
        Personnel(
            isAvailable: true,
            cost: double.parse(costController.text),
            name: nameController.text,
            description: descriptionController.text),
      );
      Navigator.pop(context);
    }
    // setBusy(false);
  }

  validateData() {
    if (nameController.text.isEmpty) {
      setValidationMessage("You need to set a Name");
    } else if (costController.text.isEmpty) {
      setValidationMessage("You need to set a Cost");
    } else if (double.tryParse(costController.text) == null) {
      setValidationMessage("Cost needs to be a number");
    } else if (descriptionController.text.isEmpty) {
      setValidationMessage("You need to set a description");
    } else {
      return true;
    }
    return false;
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
