# 🎬 GUIDE DE DÉMO & LIVE CODING - 30 POINTS

## 📋 STRUCTURE DE L'ÉVALUATION ORALE

| Critère | Points | Durée |
|---------|--------|-------|
| **Qualité de la Démo** | /10 | 2-3 min |
| **Questions Techniques** | /12 | 10-15 min |
| **Live Coding** | /8 | 5-10 min |
| **TOTAL** | **/30** | **~20-30 min** |

---

## 🎥 PARTIE 1: DÉMO (2-3 MIN MAX) - 10 POINTS

### ✅ **Script de Démo Optimisé**

**IMPORTANT** : Préparez des données de test AVANT la démo !

#### **Minute 1: Introduction (30 sec)**
```
"Bonjour, je vais vous présenter GymFuel, une application de nutrition 
pour sportifs qui calcule automatiquement les besoins caloriques 
personnalisés grâce à des algorithmes scientifiques.

L'application utilise Hive pour la persistance locale et intègre 
un image picker pour la photo de profil."
```

#### **Minute 2: Démo des Fonctionnalités (90 sec)**

**Étape 1 - Inscription (15 sec)**
```
1. Cliquer sur "Register"
2. Email: demo@gymfuel.com
3. Password: demo123
4. Cliquer "Register"
```

**Étape 2 - Configuration Profil + Photo (30 sec)**
```
1. Cliquer sur "Add Photo" → Sélectionner une image préparée
2. Remplir rapidement (données pré-remplies si possible):
   - Nom: "Alex Demo"
   - Âge: 25
   - Sexe: Male
   - Poids: 75 kg
   - Taille: 180 cm
   - Activité: Moderately Active
   - Objectif: Muscle Gain
3. Cliquer "Calculate & Save Profile"
```

**Étape 3 - Dashboard & Smart Features (30 sec)**
```
1. Montrer les calculs affichés:
   "Comme vous voyez, l'app a calculé automatiquement:
   - BMR: 1755 kcal (équation Mifflin-St Jeor)
   - TDEE: 2720 kcal (avec facteur d'activité 1.55)
   - Calories quotidiennes: 3020 kcal (objectif prise de masse +300)
   - Macros: 150g protéines, 378g glucides, 84g lipides"

2. Faire un check-in quotidien:
   "Je clique sur 'Yes, Satisfied' → Sauvegardé dans Hive"

3. Montrer la photo de profil dans l'AppBar
```

**Étape 4 - Recommandations Dynamiques (15 sec)**
```
1. Cliquer sur "Pre-Workout Meals"
   "L'app recommande ~679 kcal (22.5% du total)"
2. Cliquer sur une catégorie
   "Voici des repas adaptés avec timing et bénéfices"
```

#### **Minute 3: Persistance Hive (30 sec - OPTIONNEL)**
```
"Pour démontrer la persistance avec Hive:"
1. Fermer l'app (Ctrl+C)
2. Relancer: flutter run -d chrome
3. "Comme vous voyez, le profil et la photo sont toujours là !"
```

**⚠️ ATTENTION** : Si le temps presse, sautez cette partie !

---

### 📝 **Données de Test à Préparer**

**AVANT la démo** :
- [ ] Image de profil prête sur le bureau (nommée `profile.jpg`)
- [ ] Navigateur Chrome déjà ouvert
- [ ] Terminal prêt avec `flutter run -d chrome`
- [ ] Compte test déjà créé (optionnel)

**Valeurs à mémoriser** :
```
Email: demo@gymfuel.com
Password: demo123
Nom: Alex Demo
Âge: 25
Poids: 75 kg
Taille: 180 cm
```

---

### ✅ **Checklist Qualité de la Démo**

- [ ] **Claire et structurée** : Script préparé
- [ ] **Cas d'usage principaux** : Inscription → Profil → Calculs → Recommandations
- [ ] **Données de test** : Prêtes et rapides à saisir
- [ ] **Pas d'hésitation** : Connaître le flow par cœur
- [ ] **2-3 min MAX** : Chronométrer avant !

---

## 💬 PARTIE 2: QUESTIONS TECHNIQUES - 12 POINTS

### 🎯 **Questions Probables & Réponses**

#### **Q1: Expliquez votre code - Smart Feature #1**

**Question** : "Expliquez-moi comment fonctionne votre calcul de BMR"

**Réponse** :
```dart
// Ouvrir user_profile_hive_model.dart ligne 48

"J'utilise l'équation Mifflin-St Jeor, qui est la formule scientifique 
standard pour calculer le métabolisme de base.

Pour un homme : BMR = (10 × poids) + (6.25 × taille) - (5 × âge) + 5
Pour une femme : BMR = (10 × poids) + (6.25 × taille) - (5 × âge) - 161

La différence de 166 calories entre hommes et femmes reflète les 
différences de composition corporelle.

Ensuite, je multiplie le BMR par un facteur d'activité pour obtenir 
le TDEE (Total Daily Energy Expenditure), qui représente les calories 
totales brûlées par jour."
```

**Montrer le code** :
```dart
double calculateBMR() {
  if (gender == 'male') {
    return (10 * weight) + (6.25 * height) - (5 * age) + 5;
  } else {
    return (10 * weight) + (6.25 * height) - (5 * age) - 161;
  }
}
```

---

#### **Q2: Expliquez la logique d'un écran clé**

**Question** : "Expliquez-moi le flow du HomeScreen"

**Réponse** :
```dart
// Ouvrir home_screen.dart

"Le HomeScreen a 3 responsabilités principales:

1. CHARGEMENT DES DONNÉES (initState):
   - Je charge le check-in du jour depuis Hive
   - Je récupère les calculs nutritionnels depuis UserProfileService

2. AFFICHAGE DYNAMIQUE:
   - Si l'utilisateur a un profil, j'affiche ses calories calculées
   - Sinon, j'affiche un message par défaut
   - La photo de profil s'affiche dans l'AppBar si elle existe

3. PERSISTANCE:
   - Quand l'utilisateur fait un check-in, je le sauvegarde dans Hive
   - Ça permet de garder un historique de satisfaction quotidienne"
```

**Montrer le code** :
```dart
@override
void initState() {
  super.initState();
  _loadTodaysCheckIn(); // Charge depuis Hive
}

Future<void> _saveCheckIn(String mood) async {
  final checkIn = DailyCheckIn(
    date: todaysDate,
    mood: mood,
    timestamp: DateTime.now(),
  );
  await HiveService.saveCheckIn(checkIn); // Sauvegarde dans Hive
}
```

---

#### **Q3: Expliquez votre structure et approche**

**Question** : "Pourquoi avez-vous structuré votre code comme ça ?"

**Réponse** :
```
"J'ai utilisé un pattern Service Layer:

1. MODELS (user_profile_hive_model.dart, daily_checkin_model.dart):
   - Contiennent les données et la logique métier
   - Les calculs sont dans le modèle car ils dépendent des données

2. SERVICES (hive_service.dart, user_profile_service.dart):
   - Gèrent la persistance et la logique d'accès aux données
   - Séparation des responsabilités: HiveService pour Hive, 
     UserProfileService pour la logique profil

3. SCREENS (home_screen.dart, etc.):
   - Uniquement l'UI et l'interaction utilisateur
   - Appellent les services pour les données

Cette approche rend le code:
- Plus maintenable (chaque fichier a une responsabilité)
- Plus testable (je peux tester les services indépendamment)
- Plus réutilisable (les services peuvent être utilisés partout)"
```

---

#### **Q4: Quelles ont été vos difficultés ?**

**Réponse honnête** :
```
"Mes principales difficultés ont été:

1. HIVE SETUP:
   - Comprendre les annotations @HiveType et @HiveField
   - Générer les adapters avec build_runner
   - Gérer les types nullable (String?)

2. IMAGE PICKER:
   - Gérer les permissions (même si pas nécessaire sur web)
   - Comprendre la différence entre XFile et File
   - Afficher l'image correctement avec Image.file()

3. CALCULS INTERDÉPENDANTS:
   - S'assurer que les calculs de macros utilisent les bonnes valeurs
   - Gérer les arrondis (toStringAsFixed)

J'ai résolu ces problèmes en:
- Lisant la documentation officielle de Hive
- Testant étape par étape
- Utilisant des print() pour déboguer"
```

---

#### **Q5: Pourquoi ces choix d'implémentation ?**

**Question** : "Pourquoi Hive et pas SharedPreferences ?"

**Réponse** :
```
"J'ai choisi Hive plutôt que SharedPreferences car:

1. TYPE-SAFE:
   - Hive utilise des TypeAdapters générés
   - SharedPreferences stocke tout en String
   - Moins de risques d'erreurs de type

2. PERFORMANCE:
   - Hive est plus rapide pour des objets complexes
   - SharedPreferences est mieux pour des valeurs simples

3. STRUCTURE:
   - Hive permet de stocker des objets complets
   - Avec SharedPreferences, j'aurais dû sérialiser en JSON manuellement

4. ÉVOLUTIVITÉ:
   - Facile d'ajouter de nouveaux modèles avec Hive
   - Juste créer un nouveau @HiveType"
```

---

#### **Q6: Code généré par l'IA ?**

**SOYEZ HONNÊTE** :
```
"Oui, j'ai utilisé une IA pour:

1. GÉNÉRATION INITIALE:
   - Structure de base des écrans
   - Boilerplate code (imports, constructeurs)

2. CE QUE J'AI FAIT MOI-MÊME:
   - Tous les algorithmes de calcul (BMR, TDEE, macros)
   - L'intégration de Hive (modèles, service)
   - L'image picker
   - La logique de navigation
   - Les validations de formulaires

3. CE QUE J'AI APPRIS:
   - Comment fonctionne Hive
   - Les annotations Dart (@HiveType)
   - La programmation asynchrone (async/await)
   - Les algorithmes nutritionnels

Je peux expliquer chaque ligne de code car j'ai tout relu, 
testé et adapté à mes besoins."
```

---

## 💻 PARTIE 3: LIVE CODING - 8 POINTS

### 🎯 **Tâches Probables**

#### **Tâche 1: Ajouter une Validation**

**Demande** : "Ajoutez une validation pour que l'âge soit entre 15 et 100 ans"

**Solution** :
```dart
// Dans profile_setup_screen.dart, ligne ~230

TextFormField(
  decoration: InputDecoration(
    labelText: 'Age',
    prefixIcon: Icon(Icons.cake),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),
  keyboardType: TextInputType.number,
  onSaved: (value) => age = int.parse(value ?? '25'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    final age = int.tryParse(value);
    if (age == null) {
      return 'Please enter a valid number';
    }
    if (age < 15 || age > 100) {
      return 'Age must be between 15 and 100';
    }
    return null;
  },
),
```

**Explication** :
```
"J'ajoute une validation dans le validator:
1. Je vérifie que la valeur n'est pas vide
2. Je parse en int avec tryParse (retourne null si invalide)
3. Je vérifie que l'âge est dans la plage 15-100
4. Je retourne un message d'erreur ou null si OK"
```

---

#### **Tâche 2: Modifier un Widget**

**Demande** : "Changez la couleur du bouton 'Satisfied' en vert"

**Solution** :
```dart
// Dans home_screen.dart, ligne ~165

ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: todaysMood == 'satisfied' 
        ? Colors.green  // ← CHANGEMENT ICI
        : Colors.white,
    foregroundColor: todaysMood == 'satisfied'
        ? Colors.white
        : Colors.green,  // ← ET ICI
    // ...
  ),
  // ...
)
```

**Explication** :
```
"Je modifie le backgroundColor de Color(0xFF66BB6A) à Colors.green.
Je change aussi le foregroundColor pour garder la cohérence.
Le bouton sera vert quand sélectionné, blanc sinon."
```

---

#### **Tâche 3: Ajouter une Mini-Fonctionnalité**

**Demande** : "Affichez le nombre total de check-ins dans le HomeScreen"

**Solution** :
```dart
// Dans home_screen.dart, après la carte de check-in (ligne ~290)

// Ajouter cette méthode dans _HomeScreenState
int _getTotalCheckIns() {
  return HiveService.getAllCheckIns().length;
}

// Ajouter ce widget après la carte de check-in
Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        Icon(Icons.calendar_today, color: Color(0xFF546E7A)),
        SizedBox(width: 12),
        Text(
          'Total check-ins: ${_getTotalCheckIns()}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF37474F),
          ),
        ),
      ],
    ),
  ),
),
```

**Explication** :
```
"J'ai créé une méthode _getTotalCheckIns() qui appelle HiveService
pour récupérer tous les check-ins et retourne leur nombre.

Ensuite j'ai ajouté une Card qui affiche ce nombre avec une icône.
Le widget se met à jour automatiquement car il est dans le build()."
```

---

#### **Tâche 4: Déboguer un Bug Simple**

**Scénario** : "L'app crash quand on clique sur Logout"

**Débogage** :
```dart
// 1. Identifier le problème
"Je vais d'abord regarder le code du bouton Logout..."

// Dans home_screen.dart, ligne ~230
IconButton(
  icon: Icon(Icons.logout, color: Colors.white),
  onPressed: () async {
    await UserProfileService.clearProfile();
    Navigator.pushReplacementNamed(context, '/login');
  },
),

// 2. Analyser
"Le problème pourrait être que clearProfile() est async mais 
je n'attends pas qu'elle se termine avant de naviguer.

Ou alors, il y a un problème dans clearProfile() elle-même."

// 3. Vérifier clearProfile() dans user_profile_service.dart
static Future<void> clearProfile() async {
  await HiveService.deleteUserProfile();
}

// 4. Solution
"Je vois, il faut bien attendre que Hive supprime le profil.
Le code est déjà correct avec async/await.

Si ça crash quand même, c'est peut-être parce que la box Hive
n'est pas ouverte. Je vérifierais dans HiveService.init()."
```

---

#### **Tâche 5: Expliquer / Refactorer du Code**

**Demande** : "Expliquez ce code et proposez une amélioration"

**Code donné** :
```dart
final calorieInfo = UserProfileService.getCalorieInfo();
Text('BMR: ${calorieInfo['bmr']}'),
Text('TDEE: ${calorieInfo['tdee']}'),
Text('Daily: ${calorieInfo['daily']}'),
```

**Explication** :
```
"Ce code:
1. Récupère un Map avec toutes les infos caloriques
2. Affiche chaque valeur dans un Text widget
3. Utilise l'interpolation de string avec ${}

Le problème: Répétition de code (DRY violation)

Amélioration: Créer un widget réutilisable"
```

**Refactoring** :
```dart
// Créer un widget helper
Widget _buildCalorieRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

// Utiliser
final calorieInfo = UserProfileService.getCalorieInfo();
Column(
  children: [
    _buildCalorieRow('BMR', '${calorieInfo['bmr']} kcal'),
    _buildCalorieRow('TDEE', '${calorieInfo['tdee']} kcal'),
    _buildCalorieRow('Daily', '${calorieInfo['daily']} kcal'),
  ],
)
```

**Avantages** :
```
"Maintenant:
- Code plus DRY (Don't Repeat Yourself)
- Plus facile à maintenir (un seul endroit à modifier)
- Plus lisible
- Réutilisable ailleurs dans l'app"
```

---

## 🎯 STRATÉGIES POUR LE LIVE CODING

### ✅ **Avant de Coder**

1. **Lire la demande à voix haute**
   ```
   "Donc vous voulez que j'ajoute une validation pour l'âge..."
   ```

2. **Identifier le fichier**
   ```
   "Je vais ouvrir profile_setup_screen.dart..."
   ```

3. **Expliquer l'approche**
   ```
   "Je vais modifier le validator du champ Age..."
   ```

### ✅ **Pendant le Coding**

1. **Commenter à voix haute**
   ```
   "Je vérifie d'abord si la valeur est vide...
    Ensuite je parse en int...
    Puis je vérifie la plage..."
   ```

2. **Utiliser Ctrl+F pour trouver rapidement**
   ```
   Ctrl+F → "Age" → Trouver le TextFormField
   ```

3. **Tester immédiatement**
   ```
   "Je vais hot reload pour tester... (r dans le terminal)"
   ```

### ✅ **Après le Coding**

1. **Expliquer le changement**
   ```
   "J'ai ajouté une vérification que l'âge est entre 15 et 100"
   ```

2. **Tester devant le prof**
   ```
   "Si j'entre 10... Voilà, message d'erreur !"
   ```

---

## 📝 CHECKLIST FINALE AVANT PRÉSENTATION

### **Préparation Technique**
- [ ] App fonctionne sans erreur
- [ ] Données de test prêtes
- [ ] Image de profil prête
- [ ] VS Code ouvert avec les fichiers clés
- [ ] Terminal prêt avec `flutter run -d chrome`
- [ ] Hot reload testé (touche 'r')

### **Préparation Mentale**
- [ ] Script de démo mémorisé
- [ ] Réponses aux questions fréquentes relues
- [ ] Fichiers clés identifiés:
  - `user_profile_hive_model.dart` (Smart Feature #1)
  - `home_screen.dart` (Flow principal)
  - `hive_service.dart` (Persistance)
  - `profile_setup_screen.dart` (Image Picker)
- [ ] Savoir naviguer rapidement dans le code (Ctrl+P)

### **Attitude**
- [ ] Être honnête sur l'utilisation de l'IA
- [ ] Parler clairement et pas trop vite
- [ ] Si vous ne savez pas: "Je ne suis pas sûr, mais je pense que..."
- [ ] Montrer votre compréhension, pas juste réciter

---

## 🎓 SCORING ESTIMÉ

### **Démo (10 points)**
- Structure claire: 3/3
- Cas d'usage: 3/3
- Données préparées: 2/2
- Fluidité: 2/2
**Total: 10/10** ✅

### **Questions Techniques (12 points)**
- Explication code: 4/4
- Smart Feature: 3/3
- Logique écrans: 2/2
- Structure: 2/2
- Difficultés: 1/1
**Total: 12/12** ✅

### **Live Coding (8 points)**
- Compréhension tâche: 2/2
- Approche correcte: 3/3
- Code fonctionnel: 2/2
- Explication: 1/1
**Total: 8/8** ✅

---

## 💡 DERNIERS CONSEILS

### **Si vous bloquez pendant le live coding:**
1. **Respirez** : "Laissez-moi réfléchir une seconde..."
2. **Verbalisez** : "Je pense que le problème est..."
3. **Utilisez la doc** : "Je peux vérifier la documentation ?"
4. **Soyez honnête** : "Je ne suis pas sûr, mais j'essaierais..."

### **Si le prof pose une question difficile:**
1. **Reformulez** : "Si je comprends bien, vous demandez..."
2. **Répondez ce que vous savez** : "Ce que je sais, c'est que..."
3. **Admettez les limites** : "Je n'ai pas approfondi cette partie, mais..."

### **Points à éviter:**
- ❌ Dire "Je ne sais pas" sans essayer
- ❌ Inventer des réponses
- ❌ Paniquer si ça ne compile pas
- ❌ Critiquer votre propre code

### **Points à faire:**
- ✅ Montrer votre processus de réflexion
- ✅ Expliquer vos choix
- ✅ Être enthousiaste
- ✅ Poser des questions si pas clair

---

**Vous êtes prêt ! Bonne chance pour votre présentation ! 🚀💪**

Votre projet est solide, vous comprenez le code, vous allez réussir ! 🎓✨
