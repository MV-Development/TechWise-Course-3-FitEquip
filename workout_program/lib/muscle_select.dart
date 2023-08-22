import 'package:flutter/material.dart';
import 'package:workout_program/globals.dart';
import 'icon_generator.dart';
import 'ui_navigation.dart';
//import 'globals.dart';
//import 'ui_assets.dart';

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
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          //toEquipButton(context)
          ElevatedButton(
            onPressed: () {
              toEquipment(context);
            },
            child: const Text('Next'),
          )
        ],
      ))
    ])));
  }

  Column muscleSelect() {
    var icons = IconGenerator();
    List<Widget> rows = [];
    for (int i = 0; i < icons.muscleIcons.length; i += 2) {
      List<Widget> rowWidgets = [];
      for (int j = i; j < i + 2 && j < icons.muscleIcons.length; j++) {
        rowWidgets.add(muscleGroupIcons(
            icons.getmURL(j), icons.getmTag(j), j, colorList[j]));
      }
      rows.add(Row(children: rowWidgets));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rows,
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
                  buttonsSelect[index] = 1;
                  setState(() {
                    colorList[index] = Color.fromARGB(255, 242, 66, 127);
                  });
                } else {
                  buttonsSelect[index] = 0;
                  muscleList.removeWhere((item) => item == label.toLowerCase());
                  setState(() {
                    colorList[index] = Colors.white;
                  });
                }
              },
              child: Image.asset(imagePath, height: 100, width: 100),
            ),
          ],
        ),
        Text(label,
            style: TextStyle(
              color: Colors.white,
            )),
      ],
    );
  }
}
