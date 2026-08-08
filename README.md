# 🏫 Al-Furqan Private Schools App (تطبيق مدارس الفرقان الخاصة)

[![Flutter](https://img.shields.io/badge/Flutter-v3.24+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-v3.5.3+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green.svg)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FCM%20%7C%20Analytics-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![Version](https://img.shields.io/badge/Version-3.2.1%2B110-blue.svg)](pubspec.yaml)
[![License](https://img.shields.io/badge/Rights-Sync%20Qatar%20%2F%20Al--Furqan-8A1538.svg)](https://syncqatar.com)

A comprehensive cross-platform mobile application built with Flutter for **Al-Furqan Private Schools in Qatar (مدارس الفرقان الخاصة)**. The application serves prospective students, public visitors, and provides dedicated authenticated portals for **Students**, **Parents**, and **Teachers**.

---

## 📑 Table of Contents

- [Features by User Role](#-features-by-user-role)
  - [1. Public / Guest Visitors](#1-public--guest-visitors)
  - [2. Student Portal](#2-student-portal)
  - [3. Parent Portal](#3-parent-portal)
  - [4. Teacher Portal](#4-teacher-portal)
- [Tech Stack & Dependencies](#-tech-stack--dependencies)
- [Project Architecture & Directory Structure](#-project-architecture--directory-structure)
- [Prerequisites](#-prerequisites)
- [Installation & Setup](#-installation--setup)
- [Firebase Configuration](#-firebase-configuration)
- [Running the Project](#-running-the-project)
- [Building for Production](#-building-for-production)
  - [Android (APK & App Bundle)](#android-apk--app-bundle)
  - [iOS (IPA & Archive)](#ios-ipa--archive)
- [Configuration & Customization](#-configuration--customization)
- [Troubleshooting & FAQs](#-troubleshooting--faqs)
- [License & Intellectual Property](#-license--intellectual-property)

---

## 🌟 Features by User Role

### 1. Public / Guest Visitors
* **Multi-Stage School Selection**: Switch between **Elementary (الابتدائية)**, **Preparatory (الاعدادية)**, and **Secondary (الثانوية)** schools, as well as educational department hubs.
* **School Overview**: Vision, mission statement, Director's address, and general information.
* **News & Announcements**: Interactive news feed with details view and banner sliders.
* **Photo & Video Galleries**: Categorized multimedia albums and video streaming.
* **Curricula & Subjects**: Information on school curriculum and educational subjects.
* **Online Admission Form (طلب إلتحاق)**: Digital application for prospective students with validation.
* **Contact & Location**: Interactive maps integration (`map_launcher`) pointing to school coordinates, direct WhatsApp links, social media channels, and complaint submission.
* **Bilingual Support**: Full Arabic (RTL) and English language toggling.

### 2. Student Portal
* **Homework & Assignments (الواجبات المدرسية)**: View assigned homework, descriptions, due dates, and attachment files.
* **Question Bank (بنك الأسئلة)**: Access subject-specific questions and exam prep materials.
* **Class Timetables & Schedules (الجدول المدرسي)**: View class schedules and periods.
* **Electronic Files & Important Tools (الملفات والبرامج)**: Download school files, resources, and documents.
* **Ask Teacher (اسئلة للطلاب)**: Submit academic questions to instructors and receive responses.
* **Messaging (الرسائل)**: Inbox, sent messages, and direct messaging to teachers and administration.
* **Academic Results (النتائج)**: Direct portal access to annual grades and report cards.

### 3. Parent Portal
* **Multi-Student Switcher (قائمة الطلاب)**: Seamlessly toggle between multiple registered children under a single parent account.
* **Student Profile (بيانات الطالب)**: View student information, class, registration status, and details.
* **Academic & Behavioral Reports (التقارير)**: Real-time progress and evaluation reports issued by teachers.
* **Attendance & Absence Logs (الغياب والحضور)**: Live tracking of student attendance and recorded absences.
* **Parent-School Messaging**: Direct communication channel with teachers and administration.

### 4. Teacher Portal
* **Student Evaluation Reports (إرسال تقرير)**: Filter by educational level, class, and student to issue progress reports.
* **Homework Dispatch (الواجبات)**: Create and monitor homework tasks for assigned classes.
* **Question Bank Management**: Manage subject question repositories.
* **Teaching Schedule (جدول الحصص)**: Weekly schedule of teaching periods.
* **Teacher Messaging**: Communicate directly with students and parents.

---

## 🛠 Tech Stack & Dependencies

| Category | Technology / Library |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) (Dart SDK `^3.5.3`) |
| **State Management** | [GetX](https://pub.dev/packages/get) & [Provider](https://pub.dev/packages/provider) |
| **Networking** | [Dio](https://pub.dev/packages/dio) |
| **Push Notifications** | [Firebase Messaging (FCM)](https://pub.dev/packages/firebase_messaging) & [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) |
| **Analytics** | [Firebase Analytics](https://pub.dev/packages/firebase_analytics) |
| **Local Storage** | [shared_preferences](https://pub.dev/packages/shared_preferences) |
| **Media & UI** | `cached_network_image`, `carousel_slider`, `expandable`, `flutter_html`, `webview_flutter` |
| **System Utilities** | `image_picker`, `file_picker`, `open_file`, `file_saver`, `url_launcher`, `map_launcher`, `share_plus` |
| **Typography** | Custom `DroidKufi` Arabic font family (Regular & Bold) |

---

## 📁 Project Architecture & Directory Structure

```
al_furqan_school/
├── android/                     # Android native platform project & Gradle configuration
├── ios/                         # iOS native Xcode project & Podfile
├── assets/
│   ├── fonts/                   # Custom fonts (DroidKufiRegular.ttf, DroidKufiBold.ttf)
│   └── images/                  # App brand logos, icons, placeholder images
├── i18n/
│   ├── ar.json                  # Arabic translation strings (Default)
│   └── en.json                  # English translation strings
├── lib/
│   ├── firebase_options.dart    # Firebase initialization settings per platform
│   ├── main.dart                # Application entrypoint & theme setup
│   ├── I10n/                    # Localization controllers & AppLocalizations delegate
│   ├── globals/
│   │   ├── CommonSetting.dart   # Base API URLs & Domain links
│   │   ├── commonStyles.dart    # Brand colors, typography, screen dimension helpers
│   │   ├── helpers.dart         # Connectivity checkers, dialogs, URL launchers
│   │   └── widgets/             # Reusable UI widgets (Drawer, Cards, Buttons, Fields)
│   ├── models/                  # Data entity models (AppInfo, Student, Parent, Teacher, etc.)
│   ├── services/                # API integration services (Dio HTTP requests)
│   └── views/                   # Screens & UI grouped by user role and feature
│       ├── startScreens/        # School stage selection screen
│       ├── homescreen/          # Main landing dashboard
│       ├── auth/login/          # Multi-role authentication screen
│       ├── loggedUser/          # Student portal screens & controllers
│       ├── Student/             # Student schedules, books, asked questions
│       ├── parents/             # Parent portal screens & controllers
│       ├── teacher/             # Teacher portal screens & controllers
│       ├── appData/             # Informational screens (About, News, Privacy, Terms)
│       └── other/               # Join application form & multimedia albums
├── pubspec.yaml                 # Flutter project dependencies & asset definitions
└── README.md                    # Project documentation
```

---

## 📋 Prerequisites

Before setting up and running this project, ensure you have installed:

1. **Flutter SDK**: Version `3.24.x` or higher (compatible with Dart `^3.5.3`).
   * Verify installation with:
     ```bash
     flutter --version
     flutter doctor
     ```
2. **Java Development Kit (JDK)**: JDK 11 or JDK 17.
3. **Android Studio** (for Android development):
   * Android SDK (API Level 25 minimum, target API Level 35).
   * Android SDK Command-line Tools and Build-Tools.
4. **Xcode & CocoaPods** (for iOS development, macOS only):
   * Xcode 15+
   * CocoaPods (`sudo gem install cocoapods`)
5. **Git**: For version control.

---

## 🚀 Installation & Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/AhmedElbasha97/al_furqan_school.git
cd al_furqan_school
```

### Step 2: Verify Flutter Environment

Run `flutter doctor` to ensure all toolchains are operational:

```bash
flutter doctor
```

### Step 3: Install Dependencies

Fetch all Dart and Flutter packages declared in `pubspec.yaml`:

```bash
flutter pub get
```

### Step 4: iOS CocoaPods Setup (macOS only)

```bash
cd ios
pod install --repo-update
cd ..
```

---

## 🔥 Firebase Configuration

The app relies on Firebase for Push Notifications (FCM) and Analytics.

1. **Android**: Place your `google-services.json` file inside the `android/app/` directory:
   ```
   android/app/google-services.json
   ```
2. **iOS**: Place your `GoogleService-Info.plist` file inside the `ios/Runner/` directory:
   ```
   ios/Runner/GoogleService-Info.plist
   ```
3. **Firebase Options**: The configuration is mapped in `lib/firebase_options.dart`. If you are connecting a new Firebase project, regenerate options using the FlutterFire CLI:
   ```bash
   flutterfire configure
   ```

---

## 📱 Running the Project

### Running in Debug Mode

Connect an Android emulator, iOS simulator, or physical device:

```bash
# Check connected devices
flutter devices

# Run the app on the default device
flutter run

# Run on a specific device
flutter run -d <DEVICE_ID>
```

### Running with Flavor / Release Mode

```bash
flutter run --release
```

---

## 📦 Building for Production

### Android (APK & App Bundle)

#### 1. Configure Keystore for Release Signing
Ensure `key.properties` is configured in `android/key.properties` (or your root project):
```properties
keyAlias=<YOUR_KEY_ALIAS>
keyPassword=<YOUR_KEY_PASSWORD>
storeFile=<PATH_TO_KEYSTORE_FILE>
storePassword=<YOUR_STORE_PASSWORD>
```

#### 2. Build Release APK:
```bash
flutter build apk --release
```
*Output location:* `build/app/outputs/flutter-apk/app-release.apk`

#### 3. Build Release Android App Bundle (for Google Play):
```bash
flutter build appbundle --release
```
*Output location:* `build/app/outputs/bundle/release/app-release.aab`

---

### iOS (IPA & Archive)

#### 1. Open in Xcode:
```bash
open ios/Runner.xcworkspace
```

#### 2. Configure Signing & Capabilities:
* Select `Runner` target -> **Signing & Capabilities**.
* Select your **Team** and set the **Bundle Identifier** (`com.sync.al_furqan_school`).
* Ensure **Push Notifications** and **Background Modes (Remote notifications)** are enabled.

#### 3. Build IPA:
```bash
flutter build ipa --release
```

---

## ⚙️ Configuration & Customization

### Base API Endpoints
All backend API endpoints are configured in [`lib/globals/CommonSetting.dart`](lib/globals/CommonSetting.dart):
```dart
String url = "https://www.alrayyanprivateschools.com";
String baseUrl = "https://alforqanschools.sch.qa/site/api/";
```

### Color Palette & Theme Tokens
Brand colors and text styling can be customized in [`lib/globals/commonStyles.dart`](lib/globals/commonStyles.dart):
* **Main Brand Color**: `#8A1538` (Al-Furqan Maroon)
* **Secondary / Accent**: `#97BFB4` (Teal)
* **Background Light**: `#F5EEDC` (Soft Cream White)

### Localization Strings
All localized text can be updated in:
* Arabic: [`i18n/ar.json`](i18n/ar.json)
* English: [`i18n/en.json`](i18n/en.json)

---

## ❓ Troubleshooting & FAQs

| Issue | Solution |
| :--- | :--- |
| **`CocoaPods could not find compatible versions`** | Run `cd ios && pod repo update && pod install` |
| **`Gradle build failed / Desugaring error`** | Ensure `coreLibraryDesugaringEnabled true` is set in `android/app/build.gradle` and your JDK is version 11 or 17. |
| **Push notifications not appearing** | Verify that `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are properly registered in the Firebase console and APNs certificates / FCM tokens are active. |
| **Image loading errors / CORS / HTTP issues** | Ensure network endpoints use HTTPS and Android `usesCleartextTraffic` is configured if testing local HTTP servers. |

---

## 📄 License & Intellectual Property

Copyright © **Al-Furqan Private Schools** (Qatar) & **Sync Qatar**.  
All rights reserved. Unauthorized reproduction, modification, distribution, or commercial use of this codebase is strictly prohibited.
