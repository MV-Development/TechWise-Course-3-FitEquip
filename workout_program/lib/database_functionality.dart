class InstanceData {
  var bodyPartList = <String>[];
  var equipmentList = <String>[];
  var exerciseList = <String>[];
}


/*
get_exercises() {
  exerciseList = [];
  print('');
  for (var muscle in muscleList) {
    firestore.collection(muscle).get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (hasEquipment(doc.get("Equipment")) &&
              isNewExercise(doc.get("Name"))) {
            exerciseList.add(doc.get("Name"));
            print(exerciseList);
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
  print(exerciseList);
}

hasEquipment(exerciseEquipment) {
  for (var item in exerciseEquipment) {
    if (!equipList.contains(item)) {
      return false;
    }
  }
  return true;
}

isNewExercise(newExercise) {
  return !exerciseList.contains(newExercise);
}
*/