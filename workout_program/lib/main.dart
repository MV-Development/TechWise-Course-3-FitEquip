import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

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
  final muscleList = <String>[];
  final equipList = <String>[];

  getData(code) async {
    DocumentSnapshot dSnapshot =
        await firestore.collection('workouts').doc('workouts').get();
    if (dSnapshot.exists) {
      setState(() {
        text = dSnapshot[code].toString();
      });
    }
  }

  String dropdownvalue = 'Legs';
  var items = ['Legs', 'Arms', 'Back', 'Shoulders'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          leading: Image.asset('assets/FitEquipLogo.png'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [exerciseList()],
          ),
        ));
  }

  Column exerciseList() {
    final buttonsSelect = List<int>.filled(4, 0);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        children: [
          Column(children: [
            TextButton(
                onPressed: () {
                  if (buttonsSelect[0] == 0) {
                    muscleList.add('arms');
                    print(muscleList);
                    buttonsSelect[0] = 1;
                  } else {
                    buttonsSelect[0] = 0;
                    muscleList.removeWhere((item) => item == 'arms');
                    print(muscleList);
                  }
                },
                child: Image.asset('assets/Rectangle.png')),
            const Text("Arms"),
          ]),
          Column(children: [
            TextButton(
                onPressed: () {
                  if (buttonsSelect[1] == 0) {
                    muscleList.add('legs');
                    print(muscleList);
                    buttonsSelect[1] = 1;
                  } else {
                    buttonsSelect[1] = 0;
                    muscleList.removeWhere((item) => item == 'legs');
                    print(muscleList);
                  }
                },
                child: Image.asset('assets/Rectangle.png')),
            const Text("Legs"),
          ]),
          Column(children: [
            TextButton(
                onPressed: () {
                  if (buttonsSelect[2] == 0) {
                    muscleList.add('shoulders');
                    print(muscleList);
                    buttonsSelect[2] = 1;
                  } else {
                    buttonsSelect[2] = 0;
                    muscleList.removeWhere((item) => item == 'shoulders');
                    print(muscleList);
                  }
                },
                child: Image.asset('assets/Rectangle.png')),
            const Text("Shoulders"),
          ]),
          Column(children: [
            TextButton(
                onPressed: () {
                  if (buttonsSelect[3] == 0) {
                    muscleList.add('abs');
                    print(muscleList);
                    buttonsSelect[3] = 1;
                  } else {
                    buttonsSelect[3] = 0;
                    muscleList.removeWhere((item) => item == 'abs');
                    print(muscleList);
                  }
                },
                child: Image.asset('assets/Rectangle.png')),
            const Text("Abs"),
          ]),
        ],
      )
    ]);
  }

  // Column equipList() {
  //   return Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         DropdownButton(
  //             value: dropdownvalue,
  //             items: items.map((String items) {
  //               return DropdownMenuItem(
  //                 value: items,
  //                 child: Text(items),
  //               );
  //             }).toList(),
  //             onChanged: (String? newValue) {
  //               setState(() {
  //                 dropdownvalue = newValue!;
  //               });
  //             }),
  //         const SizedBox(height: 20),
  //         selectExercise(),
  //         Text(text, style: const TextStyle(fontSize: 14)),
  //       ]);
  // }

  ElevatedButton selectExercise() {
    return ElevatedButton(
      onPressed: () {
        getData(dropdownvalue.toLowerCase());
        print('button pressed!');
      },
      child: const Text('Next'),
    );
  }
}
