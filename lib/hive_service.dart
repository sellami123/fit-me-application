import 'package:hive_flutter/hive_flutter.dart';
import 'user_profile_hive_model.dart';
import 'daily_checkin_model.dart';

class HiveService {
  static const String _userProfileBox = 'userProfile';
  static const String _checkInsBox = 'dailyCheckIns';
  static const String _currentProfileKey = 'currentUser';

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(UserProfileHiveAdapter());
    Hive.registerAdapter(DailyCheckInAdapter());
    
    // Open boxes
    await Hive.openBox<UserProfileHive>(_userProfileBox);
    await Hive.openBox<DailyCheckIn>(_checkInsBox);
  }

  // User Profile Methods
  static Future<void> saveUserProfile(UserProfileHive profile) async {
    final box = Hive.box<UserProfileHive>(_userProfileBox);
    await box.put(_currentProfileKey, profile);
  }

  static UserProfileHive? getUserProfile() {
    final box = Hive.box<UserProfileHive>(_userProfileBox);
    return box.get(_currentProfileKey);
  }

  static Future<void> deleteUserProfile() async {
    final box = Hive.box<UserProfileHive>(_userProfileBox);
    await box.delete(_currentProfileKey);
  }

  static bool hasUserProfile() {
    final box = Hive.box<UserProfileHive>(_userProfileBox);
    return box.containsKey(_currentProfileKey);
  }

  // Daily Check-in Methods
  static Future<void> saveCheckIn(DailyCheckIn checkIn) async {
    final box = Hive.box<DailyCheckIn>(_checkInsBox);
    await box.put(checkIn.date, checkIn);
  }

  static DailyCheckIn? getCheckInForDate(String date) {
    final box = Hive.box<DailyCheckIn>(_checkInsBox);
    return box.get(date);
  }

  static List<DailyCheckIn> getAllCheckIns() {
    final box = Hive.box<DailyCheckIn>(_checkInsBox);
    return box.values.toList();
  }

  static Future<void> deleteCheckIn(String date) async {
    final box = Hive.box<DailyCheckIn>(_checkInsBox);
    await box.delete(date);
  }

  // Get statistics
  static Map<String, int> getCheckInStats() {
    final checkIns = getAllCheckIns();
    int satisfied = 0;
    int notSatisfied = 0;

    for (var checkIn in checkIns) {
      if (checkIn.mood == 'satisfied') {
        satisfied++;
      } else {
        notSatisfied++;
      }
    }

    return {
      'satisfied': satisfied,
      'notSatisfied': notSatisfied,
      'total': checkIns.length,
    };
  }

  // Close all boxes
  static Future<void> close() async {
    await Hive.close();
  }
}
