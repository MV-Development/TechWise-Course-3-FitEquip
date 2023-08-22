import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// Get User Data

Future<String> getUserID() async {
  return await getUID();
}

getUID() async {
  return FirebaseAuth.instance.currentUser?.uid;
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// Get Exercises

Future<List<dynamic>> getExercises(
    var userMuscleList, var userEquipmentList) async {
  var movements = [];
  FirebaseFirestore database = FirebaseFirestore.instance;
  for (var muscle in userMuscleList) {
    await database.collection(muscle).get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (isNewExercise(movements, doc.get("Name"))) {
            if (hasEquipment(userEquipmentList, doc.get("Equipment"))) {
              movements.add(doc.get("Name"));
            }
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  return movements;
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

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// save workouts

Future<void> saveWorkout(name, movementList) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  db
      .collection("users")
      .doc(await getUserID())
      .collection("workouts")
      .doc()
      .set({"Name": name, "Movements": movementList}, SetOptions(merge: true));
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// Get saved workouts

Future<List<dynamic>> getSavedWorkoutNames() async {
  var workouts = [];
  FirebaseFirestore database = FirebaseFirestore.instance;
  await database
      .collection("users")
      .doc(await getUserID())
      .collection("workouts")
      .get()
      .then(
    (querySnapshot) {
      for (var doc in querySnapshot.docs) {
        workouts.add(doc.get("Name"));
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  return workouts;
}

/*Future<List<Dynamic>>*/ void getSavedWorkoutMovements(String name) async {
  //List<String> movements = [];
  FirebaseFirestore database = FirebaseFirestore.instance;
  final workouts = database
      .collection("users")
      .doc(await getUserID())
      .collection("workouts");

  await workouts.where("Name" == name).get().then(
    (querySnapshot) {
      print(querySnapshot.toString());
    },
    onError: (e) => print("Error completing: $e"),
  );
}
