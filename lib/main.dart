import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'hive_service.dart';
import 'screen/login_screen.dart';
import 'screen/register_screen.dart';
import 'screen/home_screen.dart';
import 'screen/exercise_screen.dart';
import 'screen/food_screen.dart';
import 'screen/exercise_details_screen.dart';
import 'screen/meal_details_screen.dart';
import 'screen/profile_setup_screen.dart';
import 'screen/submission_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await HiveService.init();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymFuel - Nutrition Guide',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/profile-setup': (context) => ProfileSetupScreen(),
        '/home': (context) => HomeScreen(),
        '/pre-workout': (context) => ExerciseScreen(),
        '/post-workout': (context) => FoodScreen(),
        '/pre-workout-details': (context) => ExerciseDetailsScreen(
              mealCategory: ModalRoute.of(context)!.settings.arguments as String,
            ),
        '/post-workout-details': (context) => MealDetailsScreen(
              mealType: ModalRoute.of(context)!.settings.arguments as String,
            ),
          '/submission': (context) => SubmissionInfoScreen(),
      },
    );
  }
}
