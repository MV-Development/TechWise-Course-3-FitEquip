import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// Get Exercises
Future<List<dynamic>> getExercises(
    var userMuscleList, var userEquipmentList) async {
  var movementList = [];
  FirebaseFirestore database = FirebaseFirestore.instance;
  for (var muscle in userMuscleList) {
    await database.collection(muscle).get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (isNewExercise(movementList, doc.get("Name"))) {
            if (hasEquipment(userEquipmentList, doc.get("Equipment"))) {
              movementList.add(doc.get("Name"));
            }
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  return movementList;
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
// save workouts functionality

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
