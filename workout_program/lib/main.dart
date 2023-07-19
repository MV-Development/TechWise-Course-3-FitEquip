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
      ),
      home: const MyHomePage(title: 'Workout app'),
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

  String dropdownvalue = 'Legs';
  var items = ['Legs', 'Arms', 'Back', 'Shoulders'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 500.0, right: 500.0),
                child: DropdownButton(
                    value: dropdownvalue,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    })),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getData(dropdownvalue.toLowerCase());
                print('button pressed!');
              },
              child: const Text('Next'),
            ),
            Text(text, style: const TextStyle(fontSize: 14))
          ],
        ),
      ),
    );
  }
}
