/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'icon_generator.dart';
import 'register.dart';
import 'login.dart';
import 'database_functionality.dart';
import 'muscle_select.dart';
import 'exercises.dart';
import 'main.dart';

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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ShowExercises()));
        //print('button pressed!');
        //var data = database_functionality();
      },
      child: const Text('Next'),
    );
  }
}
*/