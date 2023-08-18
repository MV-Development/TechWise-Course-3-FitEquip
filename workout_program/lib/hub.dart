import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_program/main.dart';
import 'register.dart';
import 'muscle_select.dart';
import 'reset.dart';
import 'session_data.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key});
  @override
  State<HubPage> createState() => _HubPage();
}

class _HubPage extends State<HubPage> {
  void toMuscleSelection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PartSelect()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(
          child: Container(
        constraints: BoxConstraints(minWidth: 150, minHeight: 350),
        child: Image.asset('assets/FitEquipLogo.png', fit: BoxFit.contain),
      )),
      Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
          onPressed: () {
            muscleList = <String>[];
            buttonsSelect = List<int>.filled(7, 0);
            equipList = [""];
            equipChoice = List<int>.filled(20, 0);
            movementList = [];
            equipColorList = List.filled(20, Colors.white);
            toMuscleSelection(context);
          },
          child: Text('Make a New Workout'),
        ),
        ElevatedButton(
            onPressed: () {
              //toSavedWorkouts(context);
            },
            child: Text('View Saved Workouts'))
      ]))
    ]));
  }
}
