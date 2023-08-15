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
final buttonsSelect = List<int>.filled(7, 0);
var equipList = [""];
final equipChoice = List<int>.filled(20, 0);
var movementList = [];
final equipColorList = List.filled(20, Colors.white);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
  final colorList = List.filled(20, Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 0, 2.0, 2.0),
        child: Image.asset('assets/FitEquipLogo.png', width: 150, height: 100),
      ),
      Center(
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
      ))
    ]));
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
                    colorList[index] = Color.fromARGB(255, 242, 66, 127);
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
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 0, 2.0, 2.0),
        child: Image.asset('assets/FitEquipLogo.png', width: 150, height: 100),
      ),
      Center(
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
      ))
    ]));
  }

  Column exerciseList() {
    var icons = IconGenerator();
    List<Widget> rows = [];
    for (int i = 0; i < icons.equipIcons.length; i += 6) {
      List<Widget> rowWidgets = [];
      for (int j = i; j < i + 6 && j < icons.equipIcons.length; j++) {
        rowWidgets.add(equipmentIcons(
            icons.geteURL(j), icons.geteTag(j), j, equipColorList[j]));
      }
      rows.add(Row(children: rowWidgets));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rows,
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
                    equipColorList[index] = Color.fromARGB(255, 242, 66, 127);
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
        print('button pressed!');
        print("A");
        print("Z");
        getExercisesList(muscleList, equipList, context);
      },
      child: const Text('Next'),
    );
  }
}

//**************************************************************************

class ShowExercises extends StatefulWidget {
  final finalEquip;
  final finalMuscle;
  const ShowExercises({super.key, this.finalEquip, this.finalMuscle});

  @override
  State<ShowExercises> createState() => _ShowExercises();
}

class _ShowExercises extends State<ShowExercises> {

  void toMuscleSelection(BuildContext context){
    Navigator.push(context, 
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
                child: Image.asset('assets/FitEquipLogo.png', width: 150, height: 100),
              ),
            SizedBox(height: 18.0),
            Center (
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
                      Text(item, style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18),

          Center(
            child: ElevatedButton(
              onPressed: () {
                toMuscleSelection(context);
              },
              child: Text('Make a New Workout'),
            ),
          )
        ],
      ),
    );
  }

  
}

getExercisesList(var userMuscleList, var userEquipmentList, var context) async {
  Future<List<dynamic>> tempList =
      getExercises(userMuscleList, userEquipmentList);
  List<dynamic> tList = await tempList;
  print('final list');
  print(tList);
  movementList = tList;
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ShowExercises(finalEquip: equipList, finalMuscle: muscleList)));
}

//***************************************************************************
// database functionality
Future<List<dynamic>> getExercises(
    var userMuscleList, var userEquipmentList) async {
  FirebaseFirestore database = FirebaseFirestore.instance;
  var finalList;
  for (var muscle in userMuscleList) {
    await database.collection(muscle).get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (hasEquipment(userEquipmentList, doc.get("Equipment")) &&
              isNewExercise(movementList, doc.get("Name"))) {
            movementList.add(doc.get("Name"));
          }
        }
        print("All Docs in collection checked");
        print(movementList);
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  print("All collections checked");
  return movementList;
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
