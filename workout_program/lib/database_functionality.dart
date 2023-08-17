import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createUserEntry() async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  // Update one field, creating the document if it does not already exist.
  final data = {"Name": null};
  db
      .collection("users")
      .doc(await getUserID())
      .set(data, SetOptions(merge: true));
}

//***************************************************************************
// database functionality
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

//***************************************************************************
// save workouts functionality

Future<void> saveWorkout(movementList) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var userID = await getUserID();
  final data = {"Name": "testWrite02", "Movements": movementList};

  db.collection("users").doc(userID).collection('workouts').add(data).then(
      (documentSnapshot) =>
          print("Added Data with ID: ${documentSnapshot.id}"));
}

Future<String> getUserID() async {
  return await getUID();
}

getUID() async {
  return FirebaseAuth.instance.currentUser?.uid;
}
