import 'package:flutter/material.dart';
import 'muscle_select.dart';
import 'equip_select.dart';
import 'hub.dart';
import 'globals.dart';

void clearSelections() {
  muscleList = <String>[];
  buttonsSelect = List<int>.filled(7, 0);
  equipList = [""];
  equipChoice = List<int>.filled(20, 0);
  movementList = [];
  equipColorList = List.filled(20, Colors.white);
}

void toMuscleSelection(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const PartSelect()),
  );
}

void toHub(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => HubPage()));
}

void toEquipment(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const EquipSelect()));
}

/*
void toSavedWorkouts(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SavedWorkouts()));
}
*/