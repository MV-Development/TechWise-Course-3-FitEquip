import 'package:flutter/material.dart';
import 'database_read_write.dart';
import 'globals.dart';
import 'ui_navigation.dart';
import 'saved_workouts.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key});
  @override
  State<HubPage> createState() => _HubPage();
}

class _HubPage extends State<HubPage> {
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
            clearSelections();
            toMuscleSelection(context);
          },
          child: Text('Make a New Workout'),
        ),
        SizedBox(width: 18),
        ElevatedButton(
            onPressed: () async {
              savedWorkoutsList = await getSavedWorkoutNames();
              toSavedWorkouts(context);
            },
            child: Text('View Saved Workouts'))
      ]))
    ]));
  }
}
