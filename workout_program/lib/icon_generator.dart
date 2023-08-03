class IconGenerator {
  List<List<String>> muscleIcons = [
    ['assets/MuscleGroups/arms.png', 'Arms'],
    ['assets/muscleGroups/legs_quads.png', 'Legs'],
    ['assets/muscleGroups/shoulders.png', 'Shoulders'],
    ['assets/muscleGroups/core.png', 'Abs']
  ];

  String getmURL(index) {
    List url = muscleIcons[index];
    return url[0];
  }

  String getmTag(index) {
    List tag = muscleIcons[index];
    return tag[1];
  }
}
