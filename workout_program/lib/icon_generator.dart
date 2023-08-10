class IconGenerator {
  List<List<String>> muscleIcons = [
    ['assets/MuscleGroups/arms.png', 'Arms'],
    ['assets/muscleGroups/legs_quads.png', 'Legs'],
    ['assets/muscleGroups/shoulders.png', 'Shoulders'],
    ['assets/muscleGroups/core.png', 'Abs']
  ];
  List<List<String>> equipIcons = [
    ['assets/equipment/abRoller.png', 'Ab Roller'],
    ['assets/equipment/dumbbells.png', 'Dumbbells'],
    ['assets/equipment/latPulldown.png', 'Lat Pulldown'],
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
