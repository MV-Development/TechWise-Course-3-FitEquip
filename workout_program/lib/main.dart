import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final muscleList = <String>[];
final buttonsSelect = List<int>.filled(4, 0);
final equipList = <String>[];
final equipChoice = List<int>.filled(4, 0);
final exerciseList = <String>[];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'FitEquip'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var text = 'Exercise';
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
                'assets/muscleGroups/arms.png', 'Arms', buttonsSelect, 0),
            muscleGroupIcons(
                'assets/muscleGroups/legs_quads.png', 'Legs', buttonsSelect, 1),
            muscleGroupIcons('assets/muscleGroups/shoulders.png', 'Shoulders',
                buttonsSelect, 2),
            muscleGroupIcons(
                'assets/muscleGroups/core.png', 'Abs', buttonsSelect, 3),
          ],
        ),
      ],
    );
  }

  Widget muscleGroupIcons(
      String imagePath, String label, List<int> buttonsSelect, int index) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset('assets/Rectangle.png'),
              ),
            ),
            TextButton(
              onPressed: () {
                if (buttonsSelect[index] == 0) {
                  muscleList.add(label.toLowerCase());
                  print(muscleList);
                  buttonsSelect[index] = 1;
                } else {
                  buttonsSelect[index] = 0;
                  muscleList.removeWhere((item) => item == label.toLowerCase());
                  print(muscleList);
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
//**************************************************************************
        mikeTestingFirebase();
//**************************************************************************
      },
      child: const Text('Next'),
    );
  }
}

class EquipSelect extends StatelessWidget {
  const EquipSelect({super.key});
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
            equipmentIcons('assets/equipment/abRoller.png', 'Ab Roller', 0),
            equipmentIcons('assets/equipment/dumbbells.png', 'Dumbbells', 1),
            equipmentIcons(
                'assets/equipment/latPulldown.png', 'Lat Pulldown', 2),
            //equipmentIcons('assets/equipment/abRoller', '', 3),
          ],
        ),
      ],
    );
  }

  Widget equipmentIcons(String imagePath, String label, int index) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset('assets/Rectangle.png'),
              ),
            ),
            TextButton(
              onPressed: () {
                if (equipChoice[index] == 0) {
                  equipList.add(label.toLowerCase());
                  print(equipList);
                  equipChoice[index] = 1;
                } else {
                  equipChoice[index] = 0;
                  equipList.removeWhere((item) => item == label.toLowerCase());
                  print(equipList);
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

  ElevatedButton toExercises() {
    return ElevatedButton(
      onPressed: () {
        //Navigator.push(
        //   context, MaterialPageRoute(builder: (context) => EquipSelect()));
        print('button pressed!');
//**************************************************************************
        mikeTestingFirebase();
//**************************************************************************
      },
      child: const Text('Next'),
    );
  }
}

//***************************************************************************/
//  CollectionReference woList =
//      FirebaseFirestore.instance.collection('workouts');

//    DocumentSnapshot dSnapshot =
//        await firestore.collection('workouts').doc('workouts').get();

getExercises(userMuscles, userEquipment) {}

hasEquipment(exerciseEquipment, userEquipment) {
  return userEquipment.contains(exerciseEquipment);
}

isNewExercise(newExercise) {
  return exerciseList.contains(newExercise);
}

mikeTestingFirebase() {
  for (var muscle in muscleList) {
    firestore.collection(muscle).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('//*${docSnapshot.id} =>*/ ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
