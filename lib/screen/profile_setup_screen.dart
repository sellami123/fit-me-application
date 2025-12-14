import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../user_profile_hive_model.dart';
import '../user_profile_service.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  
  String name = '';
  String email = '';
  int age = 25;
  String gender = 'male';
  double weight = 70.0;
  double height = 170.0;
  String activityLevel = 'moderate';
  String fitnessGoal = 'maintenance';
  String dietaryPreference = 'balanced';
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadExistingProfile();
  }

  void _loadExistingProfile() {
    final existingProfile = UserProfileService.getCurrentUser();
    if (existingProfile != null) {
      setState(() {
        name = existingProfile.name;
        email = existingProfile.email;
        age = existingProfile.age;
        gender = existingProfile.gender;
        weight = existingProfile.weight;
        height = existingProfile.height;
        activityLevel = existingProfile.activityLevel;
        fitnessGoal = existingProfile.fitnessGoal;
        dietaryPreference = existingProfile.dietaryPreference;
        _profileImagePath = existingProfile.profileImagePath;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          _profileImagePath = image.path;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile photo selected! 📸'),
            backgroundColor: Color(0xFF66BB6A),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error selecting image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserProfileHive profile = UserProfileHive(
        name: name,
        email: email,
        age: age,
        gender: gender,
        weight: weight,
        height: height,
        activityLevel: activityLevel,
        fitnessGoal: fitnessGoal,
        dietaryPreference: dietaryPreference,
        profileImagePath: _profileImagePath,
      );

      await UserProfileService.setUserProfile(profile);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile saved successfully! 💪'),
          backgroundColor: Color(0xFF66BB6A),
          duration: Duration(seconds: 2),
        ),
      );
      
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup Your Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF546E7A),
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
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '📊 Calorie Calculator',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF37474F),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Enter your information to calculate your personalized calorie needs',
                  style: TextStyle(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),

                // Profile Image Picker
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF546E7A).withOpacity(0.1),
                        border: Border.all(
                          color: Color(0xFF546E7A),
                          width: 3,
                        ),
                      ),
                      child: _profileImagePath != null
                          ? ClipOval(
                              child: Image.file(
                                File(_profileImagePath!),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Color(0xFF546E7A),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Add Photo',
                                  style: TextStyle(
                                    color: Color(0xFF546E7A),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 32),

                // Name
                TextFormField(
                  initialValue: name.isEmpty ? null : name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onSaved: (value) => name = value ?? '',
                  validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                ),
                SizedBox(height: 16),

                // Age
                TextFormField(
                  initialValue: age.toString(),
                  decoration: InputDecoration(
                    labelText: 'Age',
                    prefixIcon: Icon(Icons.cake),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => age = int.parse(value ?? '25'),
                  validator: (value) => value!.isEmpty ? 'Please enter your age' : null,
                ),
                SizedBox(height: 16),

                // Gender
                DropdownButtonFormField<String>(
                  value: gender,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    prefixIcon: Icon(Icons.wc),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    DropdownMenuItem(value: 'male', child: Text('Male')),
                    DropdownMenuItem(value: 'female', child: Text('Female')),
                  ],
                  onChanged: (value) => setState(() => gender = value!),
                ),
                SizedBox(height: 16),

                // Weight
                TextFormField(
                  initialValue: weight.toString(),
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    prefixIcon: Icon(Icons.monitor_weight),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => weight = double.parse(value ?? '70'),
                  validator: (value) => value!.isEmpty ? 'Please enter your weight' : null,
                ),
                SizedBox(height: 16),

                // Height
                TextFormField(
                  initialValue: height.toString(),
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    prefixIcon: Icon(Icons.height),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => height = double.parse(value ?? '170'),
                  validator: (value) => value!.isEmpty ? 'Please enter your height' : null,
                ),
                SizedBox(height: 16),

                // Activity Level
                DropdownButtonFormField<String>(
                  value: activityLevel,
                  decoration: InputDecoration(
                    labelText: 'Activity Level',
                    prefixIcon: Icon(Icons.directions_run),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    DropdownMenuItem(value: 'sedentary', child: Text('Sedentary (little/no exercise)')),
                    DropdownMenuItem(value: 'light', child: Text('Lightly Active (1-3 days/week)')),
                    DropdownMenuItem(value: 'moderate', child: Text('Moderately Active (3-5 days/week)')),
                    DropdownMenuItem(value: 'active', child: Text('Very Active (6-7 days/week)')),
                    DropdownMenuItem(value: 'very_active', child: Text('Extremely Active (athlete)')),
                  ],
                  onChanged: (value) => setState(() => activityLevel = value!),
                ),
                SizedBox(height: 16),

                // Fitness Goal
                DropdownButtonFormField<String>(
                  value: fitnessGoal,
                  decoration: InputDecoration(
                    labelText: 'Fitness Goal',
                    prefixIcon: Icon(Icons.flag),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    DropdownMenuItem(value: 'weight_loss', child: Text('Weight Loss')),
                    DropdownMenuItem(value: 'muscle_gain', child: Text('Muscle Gain')),
                    DropdownMenuItem(value: 'maintenance', child: Text('Maintenance')),
                  ],
                  onChanged: (value) => setState(() => fitnessGoal = value!),
                ),
                SizedBox(height: 16),

                // Dietary Preference
                DropdownButtonFormField<String>(
                  value: dietaryPreference,
                  decoration: InputDecoration(
                    labelText: 'Dietary Preference',
                    prefixIcon: Icon(Icons.restaurant),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: [
                    DropdownMenuItem(value: 'balanced', child: Text('Balanced')),
                    DropdownMenuItem(value: 'vegetarian', child: Text('Vegetarian')),
                    DropdownMenuItem(value: 'vegan', child: Text('Vegan')),
                    DropdownMenuItem(value: 'high_protein', child: Text('High Protein')),
                    DropdownMenuItem(value: 'keto', child: Text('Keto')),
                  ],
                  onChanged: (value) => setState(() => dietaryPreference = value!),
                ),
                SizedBox(height: 32),

                // Save Button
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF546E7A),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Calculate & Save Profile',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
