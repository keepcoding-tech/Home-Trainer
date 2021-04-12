class StaticExercise {
  final String exercise, muscle, sets, reps, weight, restTimeMin, restTimeSec;
  StaticExercise({
    this.exercise,
    this.muscle,
    this.reps,
    this.sets,
    this.weight,
    this.restTimeMin,
    this.restTimeSec,
  });
}

class LongDistanceExercise {
  final String distance, intervals, intensity, restTimeMin, restTimeSec;
  LongDistanceExercise({
    this.distance,
    this.intervals,
    this.intensity,
    this.restTimeMin,
    this.restTimeSec,
  });
}

class ShortDistanceExercise {
  final String distance, style, sessions, restTimeMin, restTimeSec;
  ShortDistanceExercise({
    this.distance,
    this.style,
    this.sessions,
    this.restTimeMin,
    this.restTimeSec,
  });
}
