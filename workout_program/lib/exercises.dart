import 'package:flutter/material.dart';
import 'database_read_write.dart';
import 'globals.dart';
import 'ui_navigation.dart';

class ShowExercises extends StatefulWidget {
  const ShowExercises({super.key});

  @override
  State<ShowExercises> createState() => _ShowExercises();
}

class _ShowExercises extends State<ShowExercises> {
  final nameController = TextEditingController();

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
              child: Image.asset('assets/FitEquipLogo.png',
                  width: 150, height: 100),
            ),
            const SizedBox(height: 18.0),
            const Center(
              child: Text(
                "RECOMMENDED EXERCISES:",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Center(
              child: Text('Name this workout'),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1, vertical: 15),
                child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Name This Workout',
                    ))),
            const SizedBox(height: 18),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      print("Save button pressed");
                      await saveWorkout(nameController.text, movementList);
                    },
                    child: Text('Save This Workout'),
                  ),
                  SizedBox(width: 18),
                  ElevatedButton(
                    onPressed: () {
                      clearSelections();
                      toHub(context);
                    },
                    child: Text('Home'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
