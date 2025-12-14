import 'package:flutter/material.dart';

class FoodScreen extends StatelessWidget {
  void _navigateToMealDetails(BuildContext context, String mealType) {
    Navigator.pushNamed(context, '/post-workout-details', arguments: mealType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post-Workout Meals"),
        backgroundColor: Color(0xFF546E7A),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildMealCard(context, "High-Protein Recovery (400-600 cal)"),
          _buildMealCard(context, "Carb Refuel (350-550 cal)"),
          _buildMealCard(context, "Complete Balanced Meals (500-700 cal)"),
        ],
      ),
    );
  }

  Widget _buildMealCard(BuildContext context, String title) {
    // Extract category from title
    Color cardColor;
    IconData cardIcon;
    
    if (title.contains('High-Protein')) {
      cardColor = Color(0xFF37474F); // Dark blue-grey
      cardIcon = Icons.fitness_center;
    } else if (title.contains('Carb Refuel')) {
      cardColor = Color(0xFF66BB6A); // Sage green
      cardIcon = Icons.battery_charging_full;
    } else {
      cardColor = Color(0xFF7E57C2); // Muted purple
      cardIcon = Icons.restaurant;
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
