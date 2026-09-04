# 🏥 Clinic Management App (تطبيق عيادتي)

A comprehensive and elegant clinic management application built with **Flutter**, designed specifically for doctors to streamline patient records, medical sessions, and media attachments. The app natively supports Arabic (RTL) to provide a seamless user experience for Middle Eastern clinics.

## ✨ Key Features
* **Patient Management**: Add, edit, and search for patient records easily.
* **Session Tracking**: Schedule and manage medical sessions (Massage, Cupping, etc.) with statuses (Upcoming, Completed, Canceled).
* **Cloud Media Management**: Upload, view, and delete session-related medical images securely using Cloudinary API.
* **Real-time Synchronization**: Powered by Firebase Cloud Firestore for instant data updates across devices.
* **Authentication**: Secure login system with a "Remember Me" feature utilizing SharedPreferences.
* **Custom UI/UX**: Elegant gold/beige theme tailored for clinics, with custom floating Snackbars and interactive components.

## 🛠️ Tech Stack & Architecture
This project implements clean architecture principles and robust state management:

* **Framework**: Flutter (Dart)[cite: 2]
* **State Management**: BLoC / Cubit (`flutter_bloc`)[cite: 2]
* **Backend as a Service (BaaS)**: 
  * Firebase Auth (`firebase_auth`)[cite: 2]
  * Cloud Firestore (`cloud_firestore`)[cite: 2]
* **Image Hosting**: Cloudinary API (via `http`[cite: 2])
* **Local Storage**: `shared_preferences` (for session state and first-time app launch logic)[cite: 2]
* **Media Selection**: `image_picker`[cite: 2]
* **UI/UX Dependencies**: `font_awesome_flutter`, `modal_progress_hud_nsn`[cite: 2]
* **Typography**: Custom fonts (Pacifico, Sekuya)[cite: 2]

## 📂 Folder Structure
The application follows a modular and feature-first folder structure:
```text
lib/
│
├── assets/             # Images, custom icons, and fonts
├── cubits/             # State management (AddPatient, EditSession, Login, etc.)
├── helper/             # Global functions (e.g., custom_showsnackbar)
├── models/             # Data models (PatientModel, SessionModel)
├── screens/            # UI Pages (Dashboard, AddNewSession, LoginPage, etc.)
├── widget/             # Reusable UI components (CustomAppBar, CustomTextField, etc.)
├── constant.dart       # App-wide constants (Colors)
└── main.dart           # App entry point & Routing
