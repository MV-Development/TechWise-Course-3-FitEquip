// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// FirebaseFirestore database = FirebaseFirestore.instance;

// get_equipment(String muscle) {
//   database.collection(muscle).get().then(
//     (querySnapshot) {
//       return querySnapshot.docs[doc].get("Equipment");
//     },
//     onError: (e) => print("Error completing: $e"),
//   );
// }

// get_exercise_name(String muscle) {
//   database.collection(muscle).get().then(
//     (querySnapshot) {
//       return querySnapshot.docs[doc].get("Name");
//     },
//     onError: (e) => print("Error completing: $e"),
//   );
// }

// get_exercises(var muscleList, var equipmentList) {
//   var exerciseList = <String>[];
//   for (var muscle in muscleList) {
//     database.collection(muscle).get().then(
//       (querySnapshot) {
//         for (var doc in querySnapshot.docs) {
//           if (hasEquipment(doc.get("Equipment")) &&
//               isNewExercise(exerciseList, doc.get("Name"))) {
//             exerciseList.add(doc.get("Name"));
//             print(exerciseList);
//           }
//         }
//       },
//       onError: (e) => print("Error completing: $e"),
//     );
//   }
//   print(exerciseList);
//   return exerciseList;
// }

// hasEquipment(equipList, exerciseEquipment) {
//   for (var item in exerciseEquipment) {
//     if (!equipList.contains(item)) {
//       return false;
//     }
//   }
//   return true;
// }

// isNewExercise(exerciseList, newExercise) {
//   return !exerciseList.contains(newExercise);
// }
