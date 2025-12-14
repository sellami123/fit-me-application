import 'package:flutter/material.dart';

class MealDetailsScreen extends StatelessWidget {
  final String mealType;

  MealDetailsScreen({required this.mealType});

  final Map<String, List<Map<String, String>>> dishes = {
    "High-Protein Recovery (400-600 cal)": [
      {
        "name": "Grilled Chicken with Sweet Potato",
        "calories": "542",
        "carbs": "48",
        "protein": "38",
        "fat": "18",
        "timing": "Within 30-60 min post-workout",
        "benefit": "High protein for muscle repair and recovery",
        "recovery": "Optimal for muscle growth"
      },
      {
        "name": "Salmon with Quinoa & Vegetables",
        "calories": "585",
        "carbs": "52",
        "protein": "42",
        "fat": "20",
        "timing": "Within 30-60 min post-workout",
        "benefit": "Omega-3s and complete protein for recovery",
        "recovery": "Anti-inflammatory properties"
      },
      {
        "name": "Protein Shake with Banana",
        "calories": "425",
        "carbs": "45",
        "protein": "35",
        "fat": "10",
        "timing": "Within 30 min post-workout",
        "benefit": "Fast-absorbing protein for immediate recovery",
        "recovery": "Quick nutrient delivery"
      },
      {
        "name": "Tuna Salad with Whole Grain Bread",
        "calories": "468",
        "carbs": "42",
        "protein": "36",
        "fat": "14",
        "timing": "Within 1 hour post-workout",
        "benefit": "Lean protein and complex carbs",
        "recovery": "Sustained muscle repair"
      },
    ],
    "Carb Refuel (350-550 cal)": [
      {
        "name": "Pasta with Lean Ground Turkey",
        "calories": "512",
        "carbs": "68",
        "protein": "28",
        "fat": "12",
        "timing": "Within 1-2 hours post-workout",
        "benefit": "Glycogen restoration and muscle recovery",
        "recovery": "Replenishes energy stores"
      },
      {
        "name": "Rice Bowl with Beans & Vegetables",
        "calories": "445",
        "carbs": "72",
        "protein": "18",
        "fat": "8",
        "timing": "Within 1-2 hours post-workout",
        "benefit": "Complex carbs for energy replenishment",
        "recovery": "Plant-based recovery"
      },
      {
        "name": "Sweet Potato with Cottage Cheese",
        "calories": "385",
        "carbs": "58",
        "protein": "22",
        "fat": "6",
        "timing": "Within 1 hour post-workout",
        "benefit": "Fast-digesting carbs and casein protein",
        "recovery": "Balanced macro profile"
      },
    ],
    "Complete Balanced Meals (500-700 cal)": [
      {
        "name": "Steak with Brown Rice & Broccoli",
        "calories": "645",
        "carbs": "55",
        "protein": "45",
        "fat": "24",
        "timing": "Within 1-2 hours post-workout",
        "benefit": "Complete nutrition for muscle growth",
        "recovery": "Full spectrum nutrients"
      },
      {
        "name": "Chicken Burrito Bowl",
        "calories": "598",
        "carbs": "62",
        "protein": "38",
        "fat": "18",
        "timing": "Within 1-2 hours post-workout",
        "benefit": "Balanced macros for recovery and energy",
        "recovery": "Satisfying and nutritious"
      },
      {
        "name": "Egg & Avocado Toast with Fruit",
        "calories": "535",
        "carbs": "48",
        "protein": "24",
        "fat": "26",
        "timing": "Within 1 hour post-workout",
        "benefit": "Healthy fats and quality protein",
        "recovery": "Nutrient-dense recovery"
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    Color categoryColor = Color(0xFF546E7A); // Single professional color

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(mealType, style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: categoryColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: dishes[mealType]!.length,
        itemBuilder: (context, index) {
          final dish = dishes[mealType]![index];
          return _buildMealCard(dish, categoryColor);
        },
      ),
    );
  }

  Widget _buildMealCard(Map<String, String> meal, Color accentColor) {
    return Card(
      margin: EdgeInsets.only(bottom: 20.0),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white, accentColor.withOpacity(0.08)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.restaurant,
                      color: accentColor,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 16),
                  // Name and Calories
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal["name"]!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [accentColor, accentColor.withOpacity(0.8)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_fire_department, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                "${meal['calories']} kcal",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Macros Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Macronutrients",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        _buildMacroBar("Carbs", meal["carbs"]!, Color(0xFF5C6BC0)),
                        SizedBox(width: 10),
                        _buildMacroBar("Protein", meal["protein"]!, Color(0xFF7E57C2)),
                        SizedBox(width: 10),
                        _buildMacroBar("Fat", meal["fat"]!, Color(0xFF66BB6A)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Timing Section
              _buildInfoSection(
                Icons.schedule,
                "Optimal Timing",
                meal["timing"]!,
                Color(0xFF546E7A),
              ),
              SizedBox(height: 12),

              // Benefit Section
              _buildInfoSection(
                Icons.favorite,
                "Recovery Benefit",
                meal["benefit"]!,
                Color(0xFF546E7A),
              ),
              SizedBox(height: 12),

              // Recovery Info
              _buildInfoSection(
                Icons.fitness_center,
                "Why This Works",
                meal["recovery"]!,
                accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroBar(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            "${value}g",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(IconData icon, String title, String content, Color color) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2), width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color.withOpacity(0.8),
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
