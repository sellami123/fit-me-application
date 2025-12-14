import 'user_profile_hive_model.dart';
import 'hive_service.dart';

class UserProfileService {
  // Set user profile and save to Hive
  static Future<void> setUserProfile(UserProfileHive profile) async {
    await HiveService.saveUserProfile(profile);
  }

  // Get current user profile from Hive
  static UserProfileHive? getCurrentUser() {
    return HiveService.getUserProfile();
  }

  // Check if user has a profile
  static bool hasProfile() {
    return HiveService.hasUserProfile();
  }

  // Clear user profile from Hive
  static Future<void> clearProfile() async {
    await HiveService.deleteUserProfile();
  }

  // Get formatted calorie information
  static Map<String, String> getCalorieInfo() {
    final currentUser = HiveService.getUserProfile();
    
    if (currentUser == null) {
      return {
        'bmr': '0',
        'tdee': '0',
        'daily': '0',
        'preWorkout': '0',
        'postWorkout': '0',
        'protein': '0',
        'carbs': '0',
        'fats': '0',
      };
    }

    return {
      'bmr': currentUser.calculateBMR().toStringAsFixed(0),
      'tdee': currentUser.calculateTDEE().toStringAsFixed(0),
      'daily': currentUser.calculateDailyCalories().toStringAsFixed(0),
      'preWorkout': currentUser.calculatePreWorkoutCalories().toStringAsFixed(0),
      'postWorkout': currentUser.calculatePostWorkoutCalories().toStringAsFixed(0),
      'protein': currentUser.calculateProteinTarget().toStringAsFixed(0),
      'carbs': currentUser.calculateCarbsTarget().toStringAsFixed(0),
      'fats': currentUser.calculateFatTarget().toStringAsFixed(0),
    };
  }
}
