import 'package:flutter/material.dart';
import 'database_functionality.dart';
import 'muscle_select.dart';
import 'session_data.dart';

class ShowExercises extends StatefulWidget {
  const ShowExercises({super.key});

  @override
  State<ShowExercises> createState() => _ShowExercises();
}

class _ShowExercises extends State<ShowExercises> {
  void toMuscleSelection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PartSelect()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 0, 2.0, 2.0),
            child:
                Image.asset('assets/FitEquipLogo.png', width: 150, height: 100),
          ),
          SizedBox(height: 18.0),
          Center(
            child: Text(
              "RECOMMENDED EXERCISES:",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 18),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 400,
                  height: 350,
                  color: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var item in movementList)
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(width: 18),
                ElevatedButton(
                  onPressed: () async {
                    print("Save button pressed");
                    await saveWorkout(movementList);
                  },
                  child: Text('Save This Workout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
