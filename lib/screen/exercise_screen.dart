import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  void _navigateToMealDetails(BuildContext context, String mealCategory) {
    Navigator.pushNamed(context, '/pre-workout-details', arguments: mealCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pre-Workout Meals"),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildMealCard(context, "Quick Energy (150-250 cal)"),
          _buildMealCard(context, "Sustained Energy (300-500 cal)"),
          _buildMealCard(context, "Light Snacks (100-200 cal)"),
        ],
      ),
    );
  }

  Widget _buildMealCard(BuildContext context, String title) {
    // Extract calorie range from title
    Color cardColor;
    IconData cardIcon;
    
    if (title.contains('Quick Energy')) {
      cardColor = Color(0xFF546E7A); // Slate blue-grey
      cardIcon = Icons.bolt;
    } else if (title.contains('Sustained Energy')) {
      cardColor = Color(0xFF26A69A); // Teal
      cardIcon = Icons.spa;
    } else {
      cardColor = Color(0xFF5C6BC0); // Indigo
      cardIcon = Icons.cookie;
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () => _navigateToMealDetails(context, title),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cardColor, cardColor.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned(
                right: -20,
                top: -20,
                child: Icon(
                  cardIcon,
                  size: 120,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              // Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      cardIcon,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
