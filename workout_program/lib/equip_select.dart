import 'package:flutter/material.dart';
import 'icon_generator.dart';
import 'exercises.dart';
import 'globals.dart';
import 'database_read_write.dart';

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
                  equipChoice[index] = 1;
                  setState(() {
                    equipColorList[index] = Color.fromARGB(255, 242, 66, 127);
                  });
                } else {
                  equipChoice[index] = 0;
                  equipList.removeWhere((item) => item == label.toLowerCase());
                  setState(() {
                    equipColorList[index] = Colors.white;
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

  ElevatedButton toExercises() {
    return ElevatedButton(
      onPressed: () async {
        getExercisesList(muscleList, equipList, context);
      },
      child: const Text('Next'),
    );
  }
}

getExercisesList(var userMuscleList, var userEquipmentList, var context) async {
  movementList = await getExercises(userMuscleList, userEquipmentList);
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ShowExercises()));
}
