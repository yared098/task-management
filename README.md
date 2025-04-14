# task_management

📝 Objective:
Build a task management mobile app that works offline-first using Hive for local storage and Bloc for state management. Implement user roles (admin/user) and sync with a mock remote API.

🔧 Core Requirements:
1. Authentication (Local Mock)
Roles: Admin, User


Store user session with Hive


Hardcoded login credentials (admin:1234, user:1234)


2. Offline Task Management
CRUD operations for tasks


Store tasks locally using Hive


Each task should have:


Title


Description


Status (Pending, In Progress, Completed)


Assigned to (for admin only)


3. Sync Mechanism
Simulate a remote sync using JSON REST API (e.g., jsonplaceholder.typicode.com)


When online, sync local data with mock API:


New tasks


Updated tasks


Show sync status with indicator


4. Bloc Architecture
Use Bloc pattern cleanly across:


Auth flow


Task listing and management


Sync process


Structure: presentation, domain, data


5. Role-Based UI
Admin:


Can assign tasks


Can view all users’ tasks


User:


Can only view/edit their tasks


Cannot assign tasks


6. UI/UX Expectations
Clean, minimal design using flutter_bloc, flutter_hooks, and good separation of concerns


Responsive design


Material Design 3 (or Cupertino style for iOS)



✅ Bonus Points
Unit tests for Bloc or data layer


Use connectivity_plus to detect online/offline status


Animation when syncing or transitioning between states



📦 Packages to Use:
flutter_bloc


hive & hive_flutter


http


equatable


connectivity_plus


flutter_hooks (optional)


flutter_secure_storage (for session)



🧪 Submission Expectations:
GitHub repo link with README


Clear folder structure


Demo video (screen recording)
Apk for android v 14


# task-management
