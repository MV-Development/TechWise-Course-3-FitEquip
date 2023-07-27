import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final muscleList = <String>[];
final buttonsSelect = List<int>.filled(4, 0);
final equipList = <String>[];
final equipChoice = List<int>.filled(4, 0);
final equipColorList = List.filled(4, Colors.white);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FitEquip());
}

class FitEquip extends StatelessWidget {
  const FitEquip({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.deepPurple,
      ),
      home: const PartSelect(title: 'FitEquip'),
    );
  }
}

class PartSelect extends StatefulWidget {
  const PartSelect({super.key, required this.title});

  final String title;

  @override
  State<PartSelect> createState() => _PartSelectState();
}

class _PartSelectState extends State<PartSelect> {
  var text = 'Exercise';
  final colorList = List.filled(4, Colors.white);
  CollectionReference woList =
      FirebaseFirestore.instance.collection('workouts');

  getData(code) async {
    DocumentSnapshot dSnapshot =
        await firestore.collection('workouts').doc('workouts').get();
    if (dSnapshot.exists) {
      setState(() {
        text = dSnapshot[code].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          leading: Image.asset('assets/FitEquipLogo.png'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [muscleSelect()]),
            toEquip()
          ],
        )));
  }

  Column muscleSelect() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            muscleGroupIcons(
                'assets/muscleGroups/arms.png', 'Arms', 0, colorList[0]),
            muscleGroupIcons(
                'assets/muscleGroups/legs_quads.png', 'Legs', 1, colorList[1]),
            muscleGroupIcons('assets/muscleGroups/shoulders.png', 'Shoulders',
                2, colorList[2]),
            muscleGroupIcons(
                'assets/muscleGroups/core.png', 'Abs', 3, colorList[3]),
          ],
        ),
      ],
    );
  }

  Widget muscleGroupIcons(
      String imagePath, String label, int index, var curColor) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset('assets/Rectangle.png', color: curColor),
              ),
            ),
            TextButton(
              onPressed: () {
                if (buttonsSelect[index] == 0) {
                  muscleList.add(label.toLowerCase());
                  print(muscleList);
                  buttonsSelect[index] = 1;
//********************************************************************* */
                  for (var muscle in muscleList) {
                    firestore.collection(muscle).get().then(
                      (querySnapshot) {
                        for (var docSnapshot in querySnapshot.docs) {
                          print(
                              '//*${docSnapshot.id} =>*/ ${docSnapshot.data()}');
                        }
                      },
                      onError: (e) => print("Error completing: $e"),
                    );
                  }

//********************************************************************* */
                  setState(() {
                    colorList[index] = Colors.pink;
                  });
                } else {
                  buttonsSelect[index] = 0;
                  muscleList.removeWhere((item) => item == label.toLowerCase());
                  print(muscleList);
//********************************************************************* */
                  for (var muscle in muscleList) {
                    firestore.collection(muscle).get().then(
                      (querySnapshot) {
                        for (var docSnapshot in querySnapshot.docs) {
                          print(
                              '//*${docSnapshot.id} =>*/ ${docSnapshot.data()}');
                        }
                      },
                      onError: (e) => print("Error completing: $e"),
                    );
                  }

//********************************************************************* */
                  setState(() {
                    colorList[index] = Colors.white;
                  });
                }
              },
              child: Image.asset(imagePath, height: 100, width: 100),
            ),
          ],
        ),
        Text(label),
      ],
    );
  }

  ElevatedButton toEquip() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EquipSelect()));
        print('button pressed!');
      },
      child: const Text('Next'),
    );
  }
}

class EquipSelect extends StatefulWidget {
  const EquipSelect({super.key});
  @override
  _EquipSelect createState() => _EquipSelect();
}

class _EquipSelect extends State<EquipSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('FitEquip')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [exerciseList()]),
          ],
        )));
  }

  Column exerciseList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            equipmentIcons('assets/equipment/abRoller.png', 'Ab Roller', 0,
                equipColorList[0]),
            equipmentIcons('assets/equipment/dumbbells.png', 'Dumbbells', 1,
                equipColorList[1]),
            equipmentIcons('assets/equipment/latPulldown.png', 'Lat Pulldown',
                2, equipColorList[2]),
            //equipmentIcons('assets/equipment/abRoller', '', 3),
          ],
        ),
      ],
    );
  }

  Widget equipmentIcons(
      String imagePath, String label, int index, var curColor) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset('assets/Rectangle.png', color: curColor),
              ),
            ),
            TextButton(
              onPressed: () {
                if (equipChoice[index] == 0) {
                  equipList.add(label.toLowerCase());
                  print(equipList);
                  equipChoice[index] = 1;
                  setState(() {
                    equipColorList[index] = Colors.pink;
                  });
                } else {
                  equipChoice[index] = 0;
                  equipList.removeWhere((item) => item == label.toLowerCase());
                  print(equipList);
                  setState(() {
                    equipColorList[index] = Colors.white;
                  });
                }
              },
              child: Image.asset(imagePath, height: 100, width: 100),
            ),
          ],
        ),
        Text(label),
      ],
    );
  }
}

//***************************************************************************/
//  CollectionReference woList =
//      FirebaseFirestore.instance.collection('workouts');

//    DocumentSnapshot dSnapshot =
//        await firestore.collection('workouts').doc('workouts').get();

getExercises(userMuscles, userEquipment) {
  Set<String> exercises = {};
  for (var muscle in userMuscles) {
    CollectionReference exerciseList =
        FirebaseFirestore.instance.collection(muscle);

    if (hasEquipment(exerciseList, userEquipment)) {}
  }

  return exercises;
}

hasEquipment(exerciseList, userEquipment) {
  for (final doc in exerciseList) {}
}

isNewExercise(exercises, newExercise) {
  return exercises.contains(newExercise);
}
