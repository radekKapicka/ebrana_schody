
final String tableAchievement = 'achievement';

class AchievementFields{
  static final List<String> values = [
    id, user_id, datestamp, achievementlvl
  ];

  static final String id = '_id';
  static final String user_id = 'user_id';
  static final String datestamp = 'datestamp';
  static final String achievementlvl = 'achievementlvl';
}

class Achievement{
  final int? id;
  final String user_id;
  final DateTime datestamp;
  final int achievementlvl;

  const Achievement({
    this.id,
    required this.user_id,
    required this.datestamp,
    required this.achievementlvl,
  });

Achievement copy({
    int? id,
    String? user_id,
    DateTime? datestamp,
    int? achievementlvl,
  }) =>
      Achievement(
        id:id ?? this.id,
        user_id: user_id ?? this.user_id,
        datestamp: datestamp ?? this.datestamp,
        achievementlvl: achievementlvl ?? this.achievementlvl,
      );

  static Achievement fromJson(Map<String,Object?> json) => Achievement(
    id: json[AchievementFields.id] as int?,
    user_id: json[AchievementFields.user_id] as String,
    datestamp: DateTime.parse(json[AchievementFields.datestamp] as String),
    achievementlvl: json[AchievementFields.achievementlvl] as int,
  );

  Map<String, Object?> toJson() => {
    AchievementFields.id: id,
    AchievementFields.user_id: user_id,
    AchievementFields.datestamp: datestamp.toIso8601String(),
    AchievementFields.achievementlvl: achievementlvl,
  };
}