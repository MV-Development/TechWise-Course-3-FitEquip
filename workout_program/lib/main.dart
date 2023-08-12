import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'icon_generator.dart';
import 'register.dart';
import 'login.dart';
import 'database_functionality.dart';
import 'muscle_select.dart';
import 'equip_select.dart';
import 'exercises.dart';

final muscleList = <String>[];
final buttonsSelect = List<int>.filled(4, 0);
var equipList = [""];
final equipChoice = List<int>.filled(4, 0);
var movementList = [];
final equipColorList = List.filled(4, Colors.white);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await Firebase.initializeApp(
  // options: DefaultFirebaseOptions.currentPlatform,
  //);
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
      home: const LoginPage(title: 'FitEquip'),
    );
  }
}

//***************************************************************************

class PartSelect extends StatefulWidget {
  const PartSelect({super.key});
  @override
  State<PartSelect> createState() => _PartSelectState();
}

class _PartSelectState extends State<PartSelect> {
  var text = 'Exercise';
  final colorList = List.filled(4, Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("FitEquip"),
          leading: Image.asset('assets/FitEquipLogo.png'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'CHOOSE MUSCLE GROUPS:',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [muscleSelect()]),
            SizedBox(height: 18),
            toEquip()
          ],
        )));
  }

  Column muscleSelect() {
    var icons = IconGenerator();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            for (int i = 0; i < icons.muscleIcons.length; i++)
              muscleGroupIcons(
                  icons.getmURL(i), icons.getmTag(i), i, colorList[i])
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
                  setState(() {
                    colorList[index] = Colors.pink;
                  });
                } else {
                  buttonsSelect[index] = 0;
                  muscleList.removeWhere((item) => item == label.toLowerCase());
                  print(muscleList);
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EquipSelect()));
        //print('button pressed!');
      },
      child: const Text('Next'),
    );
  }
}

//***************************************************************************

class EquipSelect extends StatefulWidget {
  const EquipSelect({super.key});
  @override
  State<EquipSelect> createState() => _EquipSelect();
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
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'SELECT AVAILABLE EQUIPMENT:',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [exerciseList()]),
            SizedBox(height: 18),
            toExercises(),
          ],
        )));
  }

  Column exerciseList() {
    var icons = IconGenerator();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            for (int i = 0; i < icons.equipIcons.length; i++)
              equipmentIcons(
                  icons.geteURL(i), icons.geteTag(i), i, equipColorList[i])

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

  ElevatedButton toExercises() {
    return ElevatedButton(
      onPressed: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ShowExercises()));
        print('button pressed!');
        print("A");
        getExercises(muscleList, equipList);
        print("Z");
        print(movementList);
      },
      child: const Text('Next'),
    );
  }
}

//**************************************************************************

class ShowExercises extends StatefulWidget {
  const ShowExercises({super.key});
  @override
  State<ShowExercises> createState() => _ShowExercises();
}

class _ShowExercises extends State<ShowExercises> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Results"),
          leading: Image.asset('assets/FitEquipLogo.png'),
        ),
        body: const Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Text("Hello"),
          Text("Goodbye")
        ])));
  }
}

//***************************************************************************
// database functionality
getExercises(var userMuscleList, var userEquipmentList) {
  FirebaseFirestore database = FirebaseFirestore.instance;
  for (var muscle in userMuscleList) {
    database.collection(muscle).get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (hasEquipment(userEquipmentList, doc.get("Equipment")) &&
              isNewExercise(movementList, doc.get("Name"))) {
            movementList.add(doc.get("Name"));
            print(movementList);
          }
        }
        print("All Docs in collection checked");
        print(movementList);
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  print("All collections checked");
  print(movementList);

  //return exerciseList;
}

hasEquipment(userEquipment, exerciseEquipment) {
  for (var item in exerciseEquipment) {
    if (!userEquipment.contains(item)) {
      return false;
    }
  }
  return true;
}

isNewExercise(exerciseList, newExercise) {
  return !exerciseList.contains(newExercise);
}
