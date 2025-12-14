import 'package:hive/hive.dart';

part 'daily_checkin_model.g.dart';

@HiveType(typeId: 1)
class DailyCheckIn extends HiveObject {
  @HiveField(0)
  String date; // Format: YYYY-MM-DD

  @HiveField(1)
  String mood; // 'satisfied' or 'not_satisfied'

  @HiveField(2)
  DateTime timestamp;

  DailyCheckIn({
    required this.date,
    required this.mood,
    required this.timestamp,
  });
}
