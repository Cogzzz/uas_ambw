# uas_c14220127

Mood Journal App
Aplikasi Flutter untuk tracking mood harian dengan Firebase backend integration.
Mahasiswa: C14220127
Mata Kuliah: Pemrograman Aplikasi Mobile
Fitur Aplikasi

Authentication: Sign Up, Sign In, Sign Out dengan Firebase Auth
Mood Tracking: 8 jenis mood (Happy, Sad, Angry, Excited, Calm, Anxious, Grateful, Tired)
Notes: Tambah catatan untuk setiap mood entry
History: Lihat, search, filter, dan hapus mood entries
Session Persistence: Auto-login menggunakan SharedPreferences
Get Started Screen: Tampil hanya saat pertama kali install
Responsive UI: Design modern dengan animasi

Teknologi yang Digunakan

Framework: Flutter & Dart
Authentication: Firebase Auth
Database: Cloud Firestore
Local Storage: SharedPreferences
State Management: Provider
Date Formatting: Intl

Langkah Install dan Build
1. Clone Repository
bashgit clone <repository-url>
cd mood-journal-app
flutter pub get
2. Setup Firebase
bash# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
3. Firebase Console Setup

Buat project di Firebase Console
Enable Authentication → Email/Password
Create Firestore Database (start in test mode)
Download google-services.json ke folder android/app/

4. Update Android Configuration
Edit android/app/build.gradle:
gradleandroid {
    compileSdkVersion 33
    defaultConfig {
        minSdkVersion 23
        targetSdkVersion 33
    }
}
5. Build dan Run
bash# Development
flutter run

# Release APK
flutter build apk --release

# App Bundle (Play Store)
flutter build appbundle --release
Dummy User untuk Testing
Option 1: Buat account baru

Gunakan fitur Sign Up di aplikasi
Email: test@example.com
Password: 123456 (minimal 6 karakter)

Option 2: Account yang sudah dibuat

Email: demo@moodjournal.com
Password: demo123

Note: Jika account option 2 belum ada, silakan buat menggunakan fitur Sign Up di aplikasi
