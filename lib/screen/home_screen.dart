import 'dart:io';
import 'package:flutter/material.dart';
import '../user_profile_service.dart';
import '../hive_service.dart';
import '../daily_checkin_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? todaysMood;
  String todaysDate = DateTime.now().toString().split(' ')[0];
  
  @override
  void initState() {
    super.initState();
    _loadTodaysCheckIn();
  }
  
  void _loadTodaysCheckIn() {
    final checkIn = HiveService.getCheckInForDate(todaysDate);
    if (checkIn != null) {
      setState(() {
        todaysMood = checkIn.mood;
      });
    }
  }
  
  Future<void> _saveCheckIn(String mood) async {
    final checkIn = DailyCheckIn(
      date: todaysDate,
      mood: mood,
      timestamp: DateTime.now(),
    );
    await HiveService.saveCheckIn(checkIn);
  }
  
  @override
  Widget build(BuildContext context) {
    final calorieInfo = UserProfileService.getCalorieInfo();
    final hasProfile = UserProfileService.hasProfile();

    return Scaffold(
      appBar: AppBar(
        title: Text("GymFuel", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF546E7A),
        elevation: 10,
        actions: [
          // Profile Picture
          if (hasProfile && UserProfileService.getCurrentUser()?.profileImagePath != null)
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profile-setup');
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: FileImage(
                    File(UserProfileService.getCurrentUser()!.profileImagePath!),
                  ),
                ),
              ),
            ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/profile-setup');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await UserProfileService.clearProfile();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFECEFF1), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Calorie Dashboard
              if (hasProfile) ...[
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF546E7A), Color(0xFF37474F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          '📊 Your Daily Calories',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildCalorieStat('BMR', calorieInfo['bmr']!, 'kcal'),
                            _buildCalorieStat('TDEE', calorieInfo['tdee']!, 'kcal'),
                            _buildCalorieStat('Target', calorieInfo['daily']!, 'kcal'),
                          ],
                        ),
                        SizedBox(height: 20),
                        Divider(color: Colors.white54, thickness: 1),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildMacroStat('Protein', calorieInfo['protein']!, 'g', Color(0xFF7E57C2)),
                            _buildMacroStat('Carbs', calorieInfo['carbs']!, 'g', Color(0xFF5C6BC0)),
                            _buildMacroStat('Fats', calorieInfo['fats']!, 'g', Color(0xFF66BB6A)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                
                // Daily Satisfaction Check-in Card
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Color(0xFFECEFF1)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFF546E7A).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.assignment_turned_in, color: Color(0xFF546E7A), size: 20),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Are you satisfied with your health routine today?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF37474F),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    todaysMood = 'satisfied';
                                  });
                                  await _saveCheckIn('satisfied');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Great! Keep up the good work! 💪'),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Color(0xFF66BB6A),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: todaysMood == 'satisfied' 
                                      ? Color(0xFF66BB6A)
                                      : Colors.white,
                                  foregroundColor: todaysMood == 'satisfied'
                                      ? Colors.white
                                      : Color(0xFF66BB6A),
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  elevation: todaysMood == 'satisfied' ? 4 : 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Color(0xFF66BB6A),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Yes, Satisfied',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    todaysMood = 'not_satisfied';
                                  });
                                  await _saveCheckIn('not_satisfied');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Keep pushing! Tomorrow is a new day 💪'),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Color(0xFF546E7A),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: todaysMood == 'not_satisfied' 
                                      ? Color(0xFF546E7A)
                                      : Colors.white,
                                  foregroundColor: todaysMood == 'not_satisfied'
                                      ? Colors.white
                                      : Color(0xFF546E7A),
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  elevation: todaysMood == 'not_satisfied' ? 4 : 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Color(0xFF546E7A),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.refresh, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Need Improvement',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (todaysMood != null) ...[
                          SizedBox(height: 14),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: todaysMood == 'satisfied'
                                  ? Color(0xFF66BB6A).withOpacity(0.1)
                                  : Color(0xFF546E7A).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: todaysMood == 'satisfied'
                                    ? Color(0xFF66BB6A).withOpacity(0.3)
                                    : Color(0xFF546E7A).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: todaysMood == 'satisfied'
                                      ? Color(0xFF66BB6A)
                                      : Color(0xFF546E7A),
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Check-in recorded for $todaysDate',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF37474F),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],

              // Pre-Workout Card
              _buildFeatureCard(
                context,
                "Pre-Workout Meals",
                hasProfile ? "~${calorieInfo['preWorkout']} kcal recommended" : "Fuel your workout",
                Icons.energy_savings_leaf,
                Color(0xFF26A69A),
                '/pre-workout',
              ),
              SizedBox(height: 20),

              // Post-Workout Card
              _buildFeatureCard(
                context,
                "Post-Workout Meals",
                hasProfile ? "~${calorieInfo['postWorkout']} kcal recommended" : "Recover & grow",
                Icons.restaurant_menu,
                Color(0xFF546E7A),
                '/post-workout',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalorieStat(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildMacroStat(String label, String value, String unit, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value + unit,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String route,
  ) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: color, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
