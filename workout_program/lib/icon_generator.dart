class IconGenerator {
  List<List<String>> muscleIcons = [
    ['assets/MuscleGroups/arms.png', 'Arms'],
    ['assets/muscleGroups/legs_quads.png', 'Legs'],
    ['assets/muscleGroups/shoulders.png', 'Shoulders'],
    ['assets/muscleGroups/core.png', 'Abs'],
    ['assets/muscleGroups/chest.png', 'Chest'],
    ['assets/muscleGroups/back.png', 'Back'],
  ];

  List<List<String>> equipIcons = [
    ['assets/equipment/abRoller.png', 'Ab Roller'],
    ['assets/equipment/dumbbells.png', 'Dumbbells'],
    ['assets/equipment/latPulldown.png', 'Lat Pulldown'],
    ['assets/equipment/barbell.png', 'Barbell'],
    ['assets/equipment/kettlebells.png', 'Kettlebells'],
    ['assets/equipment/squatRack.png', 'Squat Rack'],
    ['assets/equipment/flatBench.png', 'Flat Bench'],
    ['assets/equipment/inclineBench.png', 'Incline Bench'],
    ['assets/equipment/pecDeckMachine.png', 'Pec Deck Machine'],
    ['assets/equipment/legExtension.png', 'Leg Extension'],
    ['assets/equipment/legPressMachine.png', 'Leg Press Machine'],
    ['assets/equipment/jumprope.png', 'Jump Rope'],
    ['assets/equipment/stairmaster.png', 'Stair Master'],
    ['assets/equipment/treadmill.png', 'Treadmill'],
    ['assets/equipment/stationaryBike.png', 'Stationary Bike'],
    ['assets/equipment/rowingMachine.png', 'Rowing Machine'],
    ['assets/equipment/pullUpBar.png', 'Pull Up Bar'],
    ['assets/equipment/cableMachine.png', 'Cable Machine'],
    ['assets/equipment/yogamat.png', 'Yoga Mat'],
    ['assets/equipment/stabilityBall.png', 'Stability Ball']
  ];

  String getmURL(index) {
    List url = muscleIcons[index];
    return url[0];
  }

  String getmTag(index) {
    List tag = muscleIcons[index];
    return tag[1];
  }

  String geteURL(index) {
    List url = equipIcons[index];
    return url[0];
  }

  String geteTag(index) {
    List tag = equipIcons[index];
    return tag[1];
  }
}
