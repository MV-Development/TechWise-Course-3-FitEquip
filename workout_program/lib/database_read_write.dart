import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

Future<String> getUserID() async {
  return await getUID();
}

getUID() async {
  return FirebaseAuth.instance.currentUser?.uid;
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// Get saved workouts

Future<List<dynamic>> getSavedWorkouts() async {
  var workouts = [];
  FirebaseFirestore database = FirebaseFirestore.instance;
  await database
      .collection("users")
      .doc(await getUserID())
      .collection("wourkouts")
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
