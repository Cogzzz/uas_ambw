# Mood Journal App

Aplikasi Flutter untuk tracking mood harian dengan Firebase backend integration.

**Nama**: Steven  Suryajaya Oentoro  
**NRP**: C14220127  
**Mata Kuliah**: Pemrograman Aplikasi Mobile - A

## Fitur Aplikasi

- **Authentication**: Sign Up, Sign In, Sign Out dengan Firebase Auth
- **Mood Tracking**: 8 jenis mood (Happy, Sad, Angry, Excited, Calm, Anxious, Grateful, Tired)
- **Notes**: Tambah catatan untuk setiap mood entry
- **History**: Lihat, search, filter, dan hapus mood entries
- **Session Persistence**: Auto-login menggunakan SharedPreferences
- **Get Started Screen**: Tampil hanya saat pertama kali install
- **Responsive UI**: Design modern dengan animasi

## Teknologi yang Digunakan

| Kategori | Teknologi |
|----------|-----------|
| Framework | Flutter & Dart |
| Authentication | Firebase Auth |
| Database | Cloud Firestore |
| Local Storage | SharedPreferences |
| State Management | Provider |
| Date Formatting | Intl |

## Langkah Install dan Build

### 1. Clone Repository
```bash
git clone <repository-url>
cd mood-journal-app
flutter pub get
```

### 2. Setup Firebase
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

### 3. Firebase Console Setup
1. Buat project di [Firebase Console](https://console.firebase.google.com/)
2. Enable **Authentication** → Email/Password
3. Create **Firestore Database** (start in test mode)
4. Download `google-services.json` ke folder `android/app/`

### 4. Update Android Configuration
Edit `android/app/build.gradle`:
```gradle
android {
    compileSdkVersion 33
    defaultConfig {
        minSdkVersion 23
        targetSdkVersion 33
    }
}
```
## Notes : jika error maka turunkan menjadi flutter.ndkVersion

### 5. Build dan Run
```bash
# Development
flutter run
````

## Dummy User untuk Testing
### Account yang sudah dibuat
- Email: `user@example.com`
- Password: `password123`

