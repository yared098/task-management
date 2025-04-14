lib/
│
├── core/
│   └── constants.dart          # Application constants (like mock data and credentials)
│
├── data/
│   ├── models/
│   │   └── task_model.dart     # Task model for mock data
│   ├── repositories/
│   │   └── task_repository.dart # Repository for managing tasks (mocked data)
│   └── storage/
│       └── hive_storage.dart   # Hive local storage management
│
├── domain/
│   ├── entities/
│   │   └── task_entity.dart    # Task entity (domain layer)
│   ├── usecases/
│   │   ├── get_tasks.dart      # Get tasks use case
│   │   └── add_task.dart       # Add task use case
│
├── presentation/
│   ├── auth/
│   │   ├── auth_bloc.dart      # Authentication Bloc
│   │   ├── auth_event.dart     # Authentication events
│   │   ├── auth_state.dart     # Authentication states
│   │   └── login_screen.dart   # Login screen (mock login)
│   ├── tasks/
│   │   ├── task_bloc.dart      # Task Bloc
│   │   ├── task_event.dart     # Task events
│   │   ├── task_state.dart     # Task states
│   │   ├── task_list_screen.dart # Task list UI
│   │   └── task_form.dart      # Add/Update task form UI
│   ├── widgets/
│   │   └── task_tile.dart      # Task item UI
│   ├── app.dart                # Main app configuration
│   └── main.dart               # Entry point of the application
