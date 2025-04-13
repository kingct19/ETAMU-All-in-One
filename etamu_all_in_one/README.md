# ETAMU All-in-One 📱

A role-based mobile application built with Flutter for Texas A&M University-Commerce (ETAMU), supporting Guest, Student, and Faculty access levels.

## 🚀 Features

- 🔑 Firebase Authentication (Email/Password)
- 🔁 Role Switching (Guest ⇄ Student ⇄ Faculty)
- 🔒 Persistent Login (Until Explicit Logout)
- 🌐 WebView Integration for:
  - myLEO
  - D2L (My Classes)
  - DegreeWorks (Graduate & Undergraduate)
  - Outlook (Faculty Only)
  - Library
- 🗺️ Campus Tools (Guest Only):
  - Campus Map
  - Bus Routes + Live Map
  - Lunch Menu
  - Academic Calendar
  - Campus News

## 🧭 Role-Specific Experience

| Portal   | Features Included                                                                 |
|----------|------------------------------------------------------------------------------------|
| Guest    | Calendar, Campus Map, Bus Routes, Campus News, Lunch Menu                         |
| Student  | myLEO, D2L, Library, DegreeWorks (Grad + Undergrad)                               |
| Faculty  | myLEO, D2L, Library, DegreeWorks (Grad + Undergrad), Outlook                      |

> 🌟 Guest extras are **not duplicated** in Student or Faculty portals to avoid clutter.

## 🔄 Role Switching Logic

- Guest can switch to Student or Faculty
- Student can switch to Faculty or Guest
- Faculty can switch to Student or Guest

🔁 **Once logged in**, switching back to a previously signed-in role does **not require login again**, unless the user logs out.

## 🔐 Authentication

- FirebaseAuth used for authentication
- Login credentials stored persistently
- On app startup, user is routed to the last signed-in portal (unless logged out)

## 📦 Tech Stack

- Flutter (Dart)
- Firebase Auth
- WebView for external services
- Role-based UI rendering

## 🛠 Development

Run the app:

```bash
flutter pub get
flutter run
