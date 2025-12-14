import 'package:flutter/material.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  final String mealCategory;

  ExerciseDetailsScreen({required this.mealCategory});

  final Map<String, List<Map<String, String>>> meals = {
    "Quick Energy (150-250 cal)": [
      {
        "name": "Banana with Peanut Butter",
        "calories": "220",
        "carbs": "30",
        "protein": "6",
        "fat": "8",
        "timing": "15-30 min before workout",
        "benefit": "Quick energy boost with healthy fats"
      },
      {
        "name": "Greek Yogurt with Honey",
        "calories": "180",
        "carbs": "25",
        "protein": "12",
        "fat": "3",
        "timing": "15-30 min before workout",
        "benefit": "Fast-digesting protein and simple carbs"
      },
      {
        "name": "Apple Slices with Almond Butter",
        "calories": "195",
        "carbs": "22",
        "protein": "5",
        "fat": "9",
        "timing": "15-30 min before workout",
        "benefit": "Natural sugars for immediate energy"
      },
    ],
    "Sustained Energy (300-500 cal)": [
      {
        "name": "Oatmeal with Berries & Nuts",
        "calories": "387",
        "carbs": "45",
        "protein": "20",
        "fat": "8",
        "timing": "1-2 hours before workout",
        "benefit": "Complex carbs for sustained energy"
      },
      {
        "name": "Whole Wheat Toast with Avocado & Egg",
        "calories": "425",
        "carbs": "38",
        "protein": "18",
        "fat": "22",
        "timing": "1-2 hours before workout",
        "benefit": "Balanced macros with healthy fats"
      },
      {
        "name": "Chicken & Rice Bowl",
        "calories": "465",
        "carbs": "52",
        "protein": "35",
        "fat": "12",
        "timing": "1-2 hours before workout",
        "benefit": "High protein with complex carbs"
      },
      {
        "name": "Smoothie Bowl (Banana, Protein, Granola)",
        "calories": "398",
        "carbs": "48",
        "protein": "25",
        "fat": "10",
        "timing": "1-2 hours before workout",
        "benefit": "Easy to digest, nutrient-dense"
      },
    ],
    "Light Snacks (100-200 cal)": [
      {
        "name": "Energy Bar",
        "calories": "150",
        "carbs": "20",
        "protein": "8",
        "fat": "4",
        "timing": "15 min before workout",
        "benefit": "Convenient, portable energy"
      },
      {
        "name": "Rice Cakes with Honey",
        "calories": "120",
        "carbs": "25",
        "protein": "2",
        "fat": "1",
        "timing": "15 min before workout",
        "benefit": "Light, fast-absorbing carbs"
      },
      {
        "name": "Trail Mix (Small Portion)",
        "calories": "175",
        "carbs": "18",
        "protein": "5",
        "fat": "10",
        "timing": "15 min before workout",
        "benefit": "Quick energy with healthy fats"
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    Color categoryColor = Color(0xFF546E7A); // Single professional color

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(mealCategory, style: TextStyle(color: Colors.white)),
        backgroundColor: categoryColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: meals[mealCategory]!.length,
        itemBuilder: (context, index) {
          final meal = meals[mealCategory]![index];
          return _buildMealCard(meal, categoryColor);
        },
      ),
    );
  }

  Widget _buildMealCard(Map<String, String> meal, Color accentColor) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, accentColor.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with name and calories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      meal["name"]!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_fire_department, color: Colors.white, size: 18),
                        SizedBox(width: 4),
                        Text(
                          "${meal['calories']} kcal",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Macros Row
              Row(
                children: [
                  _buildMacroChip("Carbs", meal["carbs"]!, "g", Color(0xFF5C6BC0)),
                  SizedBox(width: 8),
                  _buildMacroChip("Protein", meal["protein"]!, "g", Color(0xFF7E57C2)),
                  SizedBox(width: 8),
                  _buildMacroChip("Fat", meal["fat"]!, "g", Color(0xFF66BB6A)),
                ],
              ),
              SizedBox(height: 16),

              // Timing
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF90A4AE), width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Color(0xFF546E7A), size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        meal["timing"]!,
                        style: TextStyle(
                          color: Color(0xFF37474F),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // Benefit
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFECEFF1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF90A4AE), width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Color(0xFF546E7A), size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        meal["benefit"]!,
                        style: TextStyle(
                          color: Color(0xFF37474F),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
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

  Widget _buildMacroChip(String label, String value, String unit, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Column(
          children: [
            Text(
              "$value$unit",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
