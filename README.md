# GymFuel - Fitness & Nutrition App

## 📱 Description
GymFuel est une application Flutter de nutrition et fitness qui calcule automatiquement vos besoins caloriques personnalisés et vous recommande des repas pré et post-workout adaptés à vos objectifs.

## ✨ Fonctionnalités Principales

### 🔐 Authentification
- Inscription et connexion utilisateur
- Validation des formulaires

### 👤 Profil Personnalisé
- **📸 Photo de profil** (Image Picker - Fonctionnalité Device)
- Informations: nom, âge, sexe, poids, taille
- Niveau d'activité physique
- Objectif fitness (perte de poids, prise de masse, maintenance)
- Préférence alimentaire

### 🧮 Calculs Nutritionnels Intelligents (Smart Feature #1)
- **BMR (Basal Metabolic Rate)** - Équation Mifflin-St Jeor
- **TDEE (Total Daily Energy Expenditure)** - Basé sur le niveau d'activité
- **Calories quotidiennes** - Ajustées selon l'objectif
- **Distribution des macros** - Protéines, glucides, lipides
- **Calories pré/post-workout** - Timing optimal

### 🎯 Recommandations Personnalisées (Smart Feature #2)
- Suggestions de repas pré-workout (150-500 cal)
- Suggestions de repas post-workout (350-700 cal)
- Recommandations caloriques adaptées au profil

### 📊 Suivi Quotidien
- **Check-in de satisfaction** quotidien
- **Historique persistant** avec Hive
- Statistiques de bien-être

### 💾 Persistance Locale (Hive - Base de données locale)
- Sauvegarde automatique du profil utilisateur
- Historique des check-ins quotidiens
- Données disponibles hors-ligne

## 🛠️ Technologies Utilisées

### Framework
- **Flutter** (Dart 3.0+)
- **Material Design**

### Packages
- `hive` & `hive_flutter` - Base de données locale NoSQL
- `image_picker` - Sélection de photos (fonctionnalité device)
- `path_provider` - Gestion des chemins de fichiers

## 📋 Conformité aux Exigences du Projet

### ✅ Écrans (Minimum 5)
- ✅ 9 écrans au total
  1. Login
  2. Register
  3. Profile Setup
  4. Home (Dashboard)
  5. Pre-Workout Meals
  6. Pre-Workout Details
  7. Post-Workout Meals
  8. Post-Workout Details
  9. Submission Info

### ✅ Fonctionnalités (5-6 requises)
- ✅ 7 fonctionnalités réelles
  1. Authentification
  2. Profil personnalisé
  3. **Calculs nutritionnels intelligents** (Smart Feature)
  4. **Recommandations dynamiques** (Smart Feature)
  5. Catalogue de repas
  6. Suivi quotidien
  7. Navigation contextuelle

### ✅ Smart Features (Minimum 1)
- ✅ **Feature #1**: Algorithmes de calcul nutritionnel
  - Équation Mifflin-St Jeor pour BMR
  - Calcul TDEE avec facteurs d'activité
  - Distribution intelligente des macros
  - Ajustement selon objectifs fitness

- ✅ **Feature #2**: Recommandations personnalisées
  - Calculs pré/post-workout adaptatifs
  - Suggestions basées sur 6+ paramètres
  - Distribution temporelle optimale

### ✅ Chapitres Techniques (Maximum 1 sauté)
- ✅ **Base de données locale**: Hive (implémenté)
- ✅ **Fonctionnalités device**: Image Picker (implémenté)
- ❌ **API**: Non implémenté (1 chapitre sauté - autorisé)

### ✅ Pas de CRUD Simple
- ✅ Logique complexe au-delà du CRUD
- ✅ Algorithmes scientifiques
- ✅ Personnalisation dynamique

### ✅ Objectif Réaliste
- ✅ Application de nutrition pour sportifs
- ✅ Cas d'usage clair et pratique

## 🚀 Installation et Exécution

### Prérequis
- Flutter SDK 3.0+
- Dart 3.0+

### Installation
```powershell
# Cloner le projet
cd fit_me_app

# Installer les dépendances
flutter pub get

# Générer les adapters Hive (si nécessaire)
flutter pub run build_runner build --delete-conflicting-outputs
```

### Exécution
```powershell
# Sur Chrome (Web)
flutter run -d chrome

# Sur Windows
flutter run -d windows

# Sur un émulateur Android/iOS
flutter run
```

## 📦 Structure du Projet

```
lib/
├── main.dart                          # Point d'entrée
├── hive_service.dart                  # Service Hive (persistance)
├── user_profile_hive_model.dart       # Modèle Hive du profil
├── daily_checkin_model.dart           # Modèle Hive des check-ins
├── user_profile_service.dart          # Service de gestion du profil
├── user_service.dart                  # Service d'authentification
└── screen/
    ├── login_screen.dart              # Écran de connexion
    ├── register_screen.dart           # Écran d'inscription
    ├── profile_setup_screen.dart      # Configuration du profil + photo
    ├── home_screen.dart               # Dashboard principal
    ├── exercise_screen.dart           # Catégories pré-workout
    ├── exercise_details_screen.dart   # Détails repas pré-workout
    ├── food_screen.dart               # Catégories post-workout
    ├── meal_details_screen.dart       # Détails repas post-workout
    └── submission_info_screen.dart    # Info de soumission
```

## 🎓 Fonctionnalités Académiques

### Base de Données Locale (Hive)
- **TypeAdapter** personnalisés pour les modèles
- **Boxes** séparées pour profil et check-ins
- **Persistance** automatique
- **Statistiques** calculées depuis l'historique

### Fonctionnalités Device (Image Picker)
- Sélection d'image depuis la galerie
- Compression automatique (512x512, 85% qualité)
- Affichage dans l'interface
- Sauvegarde du chemin dans Hive

### Algorithmes Intelligents
- **Mifflin-St Jeor** pour BMR
- **Facteurs d'activité** TDEE
- **Distribution macro** optimisée
- **Timing nutritionnel** scientifique

## 👨‍🎓 Auteur
- Nom: [Votre Nom]
- Projet: Devoir Flutter - GymFuel
- Date: Décembre 2024

## 📝 Notes de Soumission
- ✅ Toutes les exigences minimales respectées
- ✅ 2 Smart Features implémentées
- ✅ Base de données locale (Hive)
- ✅ Fonctionnalité device (Image Picker)
- ✅ 9 écrans (> 5 minimum)
- ✅ 7 fonctionnalités (> 5 minimum)
- ✅ Logique complexe (pas de CRUD simple)

## 🔧 Dépendances Principales
```yaml
dependencies:
  flutter:
    sdk: flutter
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  image_picker: ^1.0.4
  path_provider: ^2.1.1

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.6
```

## 📸 Captures d'écran
[À ajouter lors de la soumission finale]

---

**GymFuel** - Votre compagnon nutrition pour une performance optimale ! 💪🥗
