import 'package:hive/hive.dart';

part 'user_profile_hive_model.g.dart';

@HiveType(typeId: 0)
class UserProfileHive extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  int age;

  @HiveField(3)
  String gender; // 'male' or 'female'

  @HiveField(4)
  double weight; // in kg

  @HiveField(5)
  double height; // in cm

  @HiveField(6)
  String activityLevel;

  @HiveField(7)
  String fitnessGoal;

  @HiveField(8)
  String dietaryPreference;

  @HiveField(9)
  String? profileImagePath; // NEW: Path to profile image

  UserProfileHive({
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.fitnessGoal,
    required this.dietaryPreference,
    this.profileImagePath,
  });

  // Calculate BMR using Mifflin-St Jeor Equation
  double calculateBMR() {
    if (gender == 'male') {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  // Calculate TDEE based on activity level
  double calculateTDEE() {
    double bmr = calculateBMR();
    double activityMultiplier;

    switch (activityLevel) {
      case 'sedentary':
        activityMultiplier = 1.2;
        break;
      case 'light':
        activityMultiplier = 1.375;
        break;
      case 'moderate':
        activityMultiplier = 1.55;
        break;
      case 'active':
        activityMultiplier = 1.725;
        break;
      case 'very_active':
        activityMultiplier = 1.9;
        break;
      default:
        activityMultiplier = 1.2;
    }

    return bmr * activityMultiplier;
  }

  // Calculate daily calorie target based on fitness goal
  double calculateDailyCalories() {
    double tdee = calculateTDEE();

    switch (fitnessGoal) {
      case 'weight_loss':
        return tdee - 500; // 500 calorie deficit
      case 'muscle_gain':
        return tdee + 300; // 300 calorie surplus
      case 'maintenance':
        return tdee;
      default:
        return tdee;
    }
  }

  // Calculate pre-workout calories (20-25% of daily calories)
  double calculatePreWorkoutCalories() {
    return calculateDailyCalories() * 0.225; // 22.5% average
  }

  // Calculate post-workout calories (25-30% of daily calories)
  double calculatePostWorkoutCalories() {
    return calculateDailyCalories() * 0.275; // 27.5% average
  }

  // Calculate protein target (1.6-2.2g per kg body weight)
  double calculateProteinTarget() {
    if (fitnessGoal == 'muscle_gain') {
      return weight * 2.0; // Higher protein for muscle gain
    } else if (fitnessGoal == 'weight_loss') {
      return weight * 1.8; // Moderate-high protein for weight loss
    } else {
      return weight * 1.6; // Maintenance
    }
  }

  // Calculate fat target (20-30% of total calories)
  double calculateFatTarget() {
    double dailyCalories = calculateDailyCalories();
    double fatCalories = dailyCalories * 0.25; // 25% of calories
    return fatCalories / 9; // 9 calories per gram of fat
  }

  // Calculate carbs target (remaining calories)
  double calculateCarbsTarget() {
    double dailyCalories = calculateDailyCalories();
    double proteinGrams = calculateProteinTarget();
    double fatGrams = calculateFatTarget();
    
    double proteinCalories = proteinGrams * 4; // 4 calories per gram
    double fatCalories = fatGrams * 9; // 9 calories per gram
    double carbCalories = dailyCalories - proteinCalories - fatCalories;
    
    return carbCalories / 4; // 4 calories per gram of carbs
  }
}
