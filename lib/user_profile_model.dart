class UserProfile {
  String name;
  String email;
  int age;
  String gender; // 'male' or 'female'
  double weight; // in kg
  double height; // in cm
  String activityLevel; // sedentary, light, moderate, active, very_active
  String fitnessGoal; // weight_loss, muscle_gain, maintenance
  String dietaryPreference; // vegetarian, vegan, high_protein, keto, balanced

  UserProfile({
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.fitnessGoal,
    required this.dietaryPreference,
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'weight': weight,
      'height': height,
      'activityLevel': activityLevel,
      'fitnessGoal': fitnessGoal,
      'dietaryPreference': dietaryPreference,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
      weight: json['weight'],
      height: json['height'],
      activityLevel: json['activityLevel'],
      fitnessGoal: json['fitnessGoal'],
      dietaryPreference: json['dietaryPreference'],
    );
  }
}
