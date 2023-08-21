import 'package:flutter/material.dart';
import 'database_read_write.dart';
import 'globals.dart';
import 'ui_navigation.dart';

class SavedWorkouts extends StatefulWidget {
  const SavedWorkouts({super.key});

  @override
  State<SavedWorkouts> createState() => _SavedWorkouts();
}

class _SavedWorkouts extends State<SavedWorkouts> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 0, 2.0, 2.0),
          child:
              Image.asset('assets/FitEquipLogo.png', width: 150, height: 100),
        ),
        const SizedBox(height: 18.0),
        const Center(
          child: Text(
            "SAVED EXERCISES:",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                    for (var item in savedWorkoutsList)
                      Text(
                        item,
                        style: const TextStyle(
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
        const SizedBox(height: 18),
        Center(
          child: ElevatedButton(
            onPressed: () {
              clearSelections();
              toHub(context);
            },
            child: Text('Home'),
          ),
        )
      ],
    )));
  }
}
