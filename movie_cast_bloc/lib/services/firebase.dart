import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '/models/director.dart';
import '/models/personnel.dart';

class FirebaseService {
  final CollectionReference _personnelReference =
      FirebaseFirestore.instance.collection("personel");

  final CollectionReference _directorReference =
      FirebaseFirestore.instance.collection("director");

  final StreamController<List<Personnel>> _personnelStreamController =
      StreamController.broadcast();

  Stream<List<Personnel>> listenToPersonnel() {
    // Register the personnel changes
    _personnelReference
        .where("isAvailable", isEqualTo: true)
        .snapshots()
        .listen((personnelSnapshots) {
      if (personnelSnapshots.docs.isNotEmpty) {
        var personnels = personnelSnapshots.docs
            .map((snapshot) =>
                Personnel.fromJson(snapshot.data() as Map<String, dynamic>))
            .where((element) => element.isAvailable)
            .toList();

        // Adding the personnel to the controller
        _personnelStreamController.add(personnels);
      }
    });
    return _personnelStreamController.stream;
  }

  addPeronneltoRoster(String documentId, String directorId) async {
    try {
      await _personnelReference.doc(documentId).set(
        {"isAvailable": false, "documentId": documentId},
        SetOptions(
          merge: true,
        ),
      );
      await _directorReference.doc(directorId).set({
        "roster": {documentId: true}
      }, SetOptions(merge: true));
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  removePeronnelfromRoster(String documentId, String directorId) async {
    try {
      await _personnelReference.doc(documentId).set(
        {"isAvailable": true},
        SetOptions(
          merge: true,
        ),
      );
      await _directorReference.doc(directorId).set({
        "roster": {documentId: false}
      }, SetOptions(merge: true));
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  getRoster(String directorId) async {
    try {
      var _director = await _directorReference.doc(directorId).get();
      if (_director.exists) {
        Director director =
            Director.fromJson(_director.data() as Map<String, dynamic>);

        var personnelList = await _personnelReference.get();
        if (personnelList != null && personnelList.docs.isNotEmpty) {
          return List.from(personnelList.docs
              .map((e) => Personnel.fromJson(e.data() as Map<String, dynamic>))
              .where(
                  (element) => director.roster.contains(element.documentId)));
        }
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future addPersonnel(Personnel personnel) async {
    try {
      await _personnelReference
          .add(
            personnel.toJson(),
          )
          .then((value) async => await _personnelReference.doc(value.id).set(
                {"documentId": value.id},
                SetOptions(
                  merge: true,
                ),
              ));
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  getDirectors() async {
    try {
      var _director = await _directorReference.get();
      if (_director.docs.isNotEmpty) {
        List<Director> _directors = _director.docs
            .map((snapshot) =>
                Director.fromJson(snapshot.data() as Map<String, dynamic>))
            .toList();

        return _directors;
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
