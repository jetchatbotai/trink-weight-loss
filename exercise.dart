enum ExerciseCategory {
  abs,
  legs,
  glutes,
  arms,
  shoulders,
  chest,
  back,
  fullBody,
  cardio,
  stretching
}

enum ExerciseDifficulty {
  beginner,
  intermediate,
  advanced
}

class Exercise {
  final String id;
  final String name;
  final String description;
  final ExerciseCategory category;
  final ExerciseDifficulty difficulty;
  final int durationSeconds;
  final int caloriesBurnEstimate;

  const Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.durationSeconds,
    required this.caloriesBurnEstimate,
  });
}
