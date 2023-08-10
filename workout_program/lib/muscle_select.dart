/*
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'icon_generator.dart';
import 'register.dart';
//import 'login.dart';
//import 'database_functionality.dart';
import 'equip_select.dart';
//import 'exercises.dart';


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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EquipSelect()));
        print('button pressed!');
      },
      child: const Text('Next'),
    );
  }
}
*/