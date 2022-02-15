import 'package:flutter/material.dart';
import 'package:movie_cast_stacked/app/app.locator.dart';
import 'package:movie_cast_stacked/models/personnel.dart';
import 'package:movie_cast_stacked/services/firebase.dart';
import 'package:movie_cast_stacked/ui/views/new_personnel/new_personnel_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewPersonnelViewModel extends FormViewModel {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final NavigationService _navigationService = locator<NavigationService>();
  Future<void> init() async {}

  Future<void> submitNewPersonnel() async {
    setBusy(true);
    if (validateData()) {
      await _firebaseService.addPersonnel(
        Personnel(
            isAvailable: true,
            cost: double.parse(costValue!),
            name: nameValue!,
            description: descriptionValue!),
      );
      _navigationService.back();
    }
    setBusy(false);
  }

  validateData() {
    if (nameValue == null || nameValue!.isEmpty) {
      setValidationMessage("You need to set a Name");
    } else if (costValue == null || costValue!.isEmpty) {
      setValidationMessage("You need to set a Cost");
    } else if (descriptionValue == null || descriptionValue!.isEmpty) {
      setValidationMessage("You need to set a description");
    } else {
      return true;
    }
    notifyListeners();
    return false;
  }

  @override
  void setFormStatus() {}
}
