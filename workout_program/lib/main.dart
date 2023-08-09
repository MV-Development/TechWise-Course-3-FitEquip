import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'icon_generator.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
final muscleList = <String>[];
final buttonsSelect = List<int>.filled(4, 0);
var equipList = [""];
final equipChoice = List<int>.filled(4, 0);
var exerciseList = [];
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
      home: const LoginPage(title: 'FitEquip'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Login'),
        leading: Image.asset('assets/FitEquipLogo.png')
      ),
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            InkWell (
              child: Text('Register'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => RegisterPage()));
              }
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:300, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email, ex: abcd@gmail.com',
                )
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:300, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter valid password',
                )
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 500, vertical: 15),
              child:  ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PartSelect()));
                  print('button pressed!');
                },
                child: const Text('Next'),
              )
              ),
          ]
        )
      )
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Register'),
        leading: Image.asset('assets/FitEquipLogo.png')
      ),
      body: Center (
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            InkWell (
              child: Text('Login'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginPage(title: 'FitEquip')));
              }
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:300, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email, ex: abcd@gmail.com',
                )
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:300, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter valid password',
                )
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 500, vertical: 15),
              child:  ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginPage(title: 'FitEquip')));
                  print('button pressed!');
                },
                child: const Text('Next'),
              )
              ),
          ]
        )
      )
    );
  }
}

class PartSelect extends StatefulWidget {
  const PartSelect({super.key});
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
          title: Text("FitEquip"),
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EquipSelect()));
        print('button pressed!');
//**************************************************************************
//        getMuscleMovements();
//**************************************************************************
      },
      child: const Text('Next'),
    );
  }
}

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
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [exerciseList(), toExercises()]),
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
      onPressed: () {
        Navigator.push(
           context, MaterialPageRoute(builder: (context) => ShowExercises()));
        print('button pressed!');
        getExercises();
      },
      child: const Text('Next'),
    );
  }
}

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              ),
            Text("Hello"),
            Text("Goodbye")
        ]
      ))
    );
  }
  
}

//***************************************************************************/

getExercises() {
  exerciseList = [];
  print('');
  for (var muscle in muscleList) {
    firestore.collection(muscle).get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (hasEquipment(doc.get("Equipment")) &&
              isNewExercise(doc.get("Name"))) {
            exerciseList.add(doc.get("Name"));
            print(exerciseList);
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  print(exerciseList);
}

hasEquipment(exerciseEquipment) {
  for (var item in exerciseEquipment) {
    if (!equipList.contains(item)) {
      return false;
    }
  }
  return true;
}

isNewExercise(newExercise) {
  return !exerciseList.contains(newExercise);
}
