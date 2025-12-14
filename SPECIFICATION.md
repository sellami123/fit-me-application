# Project Specification

## Project
- Name: GymFuel (FitMe)
- Package: devoire
- Entry: lib/main.dart
- Description: GymFuel – Nutrition & Exercise guidance app.

## Authors
- Student: (add your name here)
- Team / Group: (add group or student IDs)

## Overview
Provide a short summary of the project, goals, and main features.

## Requirements
List functional and non-functional requirements.

## Architecture
- Flutter (Dart)
- Main widgets: Login, Register, Home, Exercise, Food, Details, Profile setup

## How to run (development)
1. Install Flutter: https://flutter.dev/docs/get-started/install
2. From project root:

```powershell
flutter pub get
flutter run -d chrome
```

## How to package for submission
- Include only `lib/` and `assets/` directories at the archive root.
- Example PowerShell command (from project folder):

```powershell
Compress-Archive -Path lib,assets -DestinationPath ..\fit_me_app_submission.zip -Force
```

## Notes
- Include this SPECIFICATION.md together with your code in the submission archive.
- If special steps or environment variables are required, add them here.

## Deadline
- Date limite : 14 déc.

## Verification checklist (for grader)
- [ ] `lib` folder included
- [ ] `assets` folder included (if used)
- [ ] SPECIFICATION.md present
- [ ] README.md present (submission instructions)
